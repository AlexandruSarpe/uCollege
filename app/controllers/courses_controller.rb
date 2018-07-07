# frozen_string_literal: true

# noinspection RailsParamDefResolve
class CoursesController < ApplicationController
  # noinspection RailsParamDefResolve
  before_action :authenticate_user!

  def index
    authorize! :read, :Course
    @current_courses = select_current_courses
    @other_courses = select_other_courses
  end

  def show
    authorize! :read, :Course
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
    Course.find(params[:id]).destroy
    flash[:notice] = 'Course deleted'
    redirect_to courses_path
  end

  protected

  def select_current_courses
    if (Time.now.month < 9) && (Time.now.month >= 1)
      Course.all.where("begin_year=#{Time.now.year - 1} AND end_year=#{Time.now.year}")
          .order('course_type DESC')
    else
      Course.all.where("begin_year=#{Time.now.year} AND end_year=#{Time.now.year + 1}")
          .order('course_type DESC')
    end
  end

  def select_other_courses
    if (Time.now.month < 9) && (Time.now.month >= 1)
      Course.all.where("end_year<=#{Time.now.year - 1}")
          .order('end_year DESC, course_type DESC')
    else
      Course.all.where("end_year<=#{Time.now.year}")
          .order('end_year DESC, course_type DESC')
    end
  end
end
