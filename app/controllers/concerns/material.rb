# frozen_string_literal: true

require 'google/apis/drive_v3'

module Material
  # creating the folder of the relative course
  def create_folder(course)
    drive = Google::Apis::DriveV3::DriveService.new
    drive.client_options.application_name = 'uCollege'
    drive.authorization = Token.last.fresh_token
    file = drive.create_file({name: course,
                              mime_type: 'application/vnd.google-apps.folder'},
                             fields: 'id')
    drive.create_permission(file.id, Google::Apis::DriveV3::Permission.new(role: 'reader', type: 'anyone'))
    file.id
  end

  # getting the files of the course
  def course_files(course_folder_id)
    drive = Google::Apis::DriveV3::DriveService.new
    drive.client_options.application_name = 'uCollege'
    drive.authorization = Token.last.fresh_token
    drive.fetch_all(items: :files) do |page_token|
      drive.list_files(q: "'#{course_folder_id}' in parents",
                       spaces: 'drive',
                       fields: 'nextPageToken, files(id, name, web_view_link)',
                       page_token: page_token)
    end
  end

  def delete_file(file_id)
    drive = Google::Apis::DriveV3::DriveService.new
    drive.client_options.application_name = 'uCollege'
    drive.authorization = Token.last.fresh_token
    drive.delete_file file_id.to_s
  end

  # deleting the folder course and all its contained files
  def delete_folder(folder_id)
    drive = Google::Apis::DriveV3::DriveService.new
    drive.client_options.application_name = 'uCollege'
    drive.authorization = Token.last.fresh_token
    course_files(folder_id).each do |file|
      drive.delete_file file.id
    end
    drive.delete_file folder_id.to_s
  end

  def update_folder(id, name)
    drive = Google::Apis::DriveV3::DriveService.new
    drive.client_options.application_name = 'uCollege'
    drive.authorization = Token.last.fresh_token
    drive.update_file(id, Google::Apis::DriveV3::File.new(name: name))
  end
end
