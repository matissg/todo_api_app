class Api::V1::TagsController < ApplicationController

  # GET /api/v1/tags
  def index
    render json: Tag.all.includes(:tasks).references(:tasks)
  end

  # POST /api/v1/tags
  def create
    tag = Tag.new(tag_params)
    if tag.save
      render json: tag, status: :created
    else
      render json: tag.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/tags/1
  def update
    tag = Tag.find(params[:id].to_i)
    if tag.update(tag_params)
      render json: tag
    else
      render json: tag.errors, status: :unprocessable_entity
    end
  end

  private

    def tag_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(
        params, only: [:title]
      )
    end

end
