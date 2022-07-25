class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        students = Student.all
        render json: students
    end

    def show
        student = find_student
        render json: student
    end

    def create
        student = Student.create!(student_params)
        render json: student
    end

    def update
        student = find_student
        student.update!(student_params)
        render json: student
    end

    def destroy
        student = find_student
        student.destroy
        head :no_content
    end

    private
    def find_student
        Student.find(params[:id])
    end

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end

    def render_not_found_response
        render json: { message: "Student not found" }, status: :not_found
    end

    def render_unprocessable_entity_response
        render json: { message: "Student could not be created"}, status: :unprocessable_entity
    end
end
