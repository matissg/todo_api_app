class Api::V1::TasksController < ApplicationController

  # GET /api/v1/tasks
  def index
    render json: Task.all.includes(:task_tags).references(:tags)
  end

  # GET /api/v1/tasks/1
  def show
    render json: task
  end

  # POST /api/v1/tasks
  def create
    task = Task.new(task_params)
    if task.save
      render json: task, status: :created
    else
      render json: task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/tasks/1
  def update
    if task.update(task_params)
      render json: task
    else
      render json: task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/tasks/1
  def destroy
    task.destroy
  end

  private

    def task
      @task ||= Task.find(params[:id].to_i)
    end

    def task_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(
        params, only: [:title, :tags]
      )
    end

end
