# frozen_string_literal: true

# noinspection ALL
class EnrollmentsController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize! :read, :Enrollment
    @course = Course.find(params[:course_id])
    @students = @course.students.sort_by(&:last_name)
  end

  def show
    authorize! :update, :Enrollment
    @students = Student.all.order('last_name ASC, first_name ASC') -
        Course.find(params[:course_id]).students
  end

  def add
    authorize! :add, :Enrollment
    student = Student.find(params[:id])
    course = Course.find(params[:course_id])
    redirect_back fallback_location: course_path(course.id)
    if current_user.instance_of? Secretary
      course.students << student unless course.students.exists?(student.id)
      flash[:notice] = "Added #{student.last_name}"
    elsif course.begin_year == Time.now.year - 1 || course.begin_year == Time.now.year #&& Time.now.month <= 12 && Time.now.month > 8
      course.students << student unless course.students.exists?(student.id)
      flash[:notice] = 'Successfully enrolled'
      redirect_to course_path(course)
    else
      flash[:notice] = 'Cannot enroll, ask your secretary user'
      redirect_to course_path(course)
    end
  end

  def destroy
    authorize! :delete, :Enrollment
    student = Student.find(params[:id])
    Course.find(params[:course_id]).students.destroy(student)
    flash[:notice] = "Removed #{student.last_name}"
    redirect_to course_enrollments_path
  end
end
