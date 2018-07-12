# frozen_string_literal: true

# managing course material with google drive API
class MaterialsController < ApplicationController
  before_action :authenticate_user!
  include Material
  def index
    @course = Course.find(params[:course_id])
    if (current_user.instance_of? Student) && current_user
                                                  .courses.where("course_id=#{@course.id}").empty?
      flash[:warning] = 'Unenrolled course'
      redirect_to course_path(@course)
    end
    authorize! :read, :Material
    authorize! :create, :Material
    @files = course_files @course.material
    gon.material = @course.material
    gon.token = Token.last.fresh_token
    gon.key = ENV['Google_Picker_Key']
  end

  def destroy
    authorize! :delete, :Material
    delete_file(params[:id])
    redirect_to course_materials_path(params[:course_id])
  end
end
