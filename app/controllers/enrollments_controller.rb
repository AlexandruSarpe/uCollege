# frozen_string_literal: true

# noinspection ALL
class EnrollmentsController < ApplicationController
  before_action :authenticate_user!
  # skip_before_action :verify_authenticity_token, only: [:add, :destroy]

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
    authorize! :update, :Enrollment
    student = Student.find(params[:id])
    course = Course.find(params[:course_id])
    course.students << student unless course.students.exists?(student.id)
    flash[:notice] = "Added #{student.last_name}"
    redirect_back fallback_location: 'enrollment'
  end

  def destroy
    authorize! :delete, :Enrollment
    student = Student.find(params[:id])
    Course.find(params[:course_id]).students.destroy(student)
    flash[:notice] = "Removed #{student.last_name}"
    redirect_to course_enrollments_path
  end
end
