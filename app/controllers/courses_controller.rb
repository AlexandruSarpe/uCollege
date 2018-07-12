# frozen_string_literal: true

class CoursesController < ApplicationController
  before_action :authenticate_user!
  include Material
  def index
    authorize! :read, :Course
    @current_courses = all_current_courses
    @other_courses = all_other_courses
  end

  def enrolled
    authorize! :view, :Course
    @current_courses = enrolled_current_courses(params[:id])
    @other_courses = enrolled_other_courses(params[:id])
  end

  def enrollable
    authorize! :add, :Enrollment
    @courses = enrollable_current_courses(current_user.id)
  end

  def show
    authorize! :view, :Course
    @course = Course.find(params[:id])
  end

  def new
    authorize! :create, :Course
    @course = Course.new
  end

  def edit
    authorize! :update, :Course
    @course = Course.find(params[:id])
  end

  def create
    authorize! :create, :Course
    data = params.require(:course).permit(:name, :course_type, :begin_year, :end_year)
    unless Course.where('name=? and begin_year=? and end_year=?', data[:name], data[:begin_year], data[:end_year]).empty?
      flash[:warning] = 'Already existing course'
      redirect_to courses_path
      return
    end
    data[:material] = create_folder("#{data[:name]} #{data[:begin_year]}-#{data[:end_year]}")
    @course = Course.new(data)
    res = @course.save
    if res
      flash[:notice] = 'Course created'
    else
      flash[:warning] = 'Cannot create course'
    end
    redirect_to courses_path
  end

  def update
    authorize! :update, :Course
    data = params.require(:course).permit(:name, :course_type, :begin_year, :end_year)
    @course = Course.find(params[:id])
    update_folder(@course.material, "#{data[:name]} #{data[:begin_year]}-#{data[:end_year]}")
    res = @course.update(data)
    if res
      flash[:notice] = 'Course updated'
    else
      flash[:warning] = 'Can\'t update course'
    end
    redirect_to course_path(@course)
  end

  def destroy
    authorize! :destroy, :Course
    @course = Course.find(params[:id])
    delete_folder @course.material
    @course.destroy
    flash[:notice] = 'Course deleted'
    redirect_to courses_path
  end

  protected

  def all_current_courses
    if (Time.now.month < 9) && (Time.now.month >= 1)
      Course.all.where("begin_year>=#{Time.now.year - 1}")
          .order('course_type DESC, begin_year DESC, end_year DESC')
    else
      Course.all.where("begin_year>=#{Time.now.year}")
          .order('course_type DESC, begin_year DESC, end_year DESC')
    end
  end

  def enrollable_current_courses(student_id)
    if (Time.now.month < 9) && (Time.now.month >= 1)
      Course.all.where("begin_year=#{Time.now.year - 1}")
          .order('course_type DESC, begin_year DESC, end_year DESC') - enrolled_current_courses(student_id)
    end
  end

  def enrolled_current_courses(student_id)
    if (Time.now.month < 9) && (Time.now.month >= 1)
      Student.find(student_id).courses.all.where("begin_year=#{Time.now.year - 1} AND end_year=#{Time.now.year}")
          .order('course_type DESC, begin_year DESC, end_year DESC')
    else
      Student.find(student_id).courses.all.where("begin_year=#{Time.now.year} AND end_year=#{Time.now.year + 1}")
          .order('course_type DESC, begin_year DESC, end_year DESC')
    end
  end

  def all_other_courses
    if (Time.now.month < 9) && (Time.now.month >= 1)
      Course.all.where("end_year<=#{Time.now.year - 1}")
            .order('end_year DESC, course_type DESC')
    else
      Course.all.where("end_year<=#{Time.now.year}")
            .order('end_year DESC, course_type DESC')
    end
  end

  def enrolled_other_courses(student_id)
    if (Time.now.month < 9) && (Time.now.month >= 1)
      Student.find(student_id).courses.all.where("end_year<=#{Time.now.year - 1}")
          .order('end_year DESC, course_type DESC')
    else
      Student.find(student_id).courses.all.where("end_year<=#{Time.now.year}")
          .order('end_year DESC, course_type DESC')
    end
  end
end
