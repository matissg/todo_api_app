require 'rails_helper'

RSpec.describe "Api::V1::Tasks", type: :request do

  let(:task) { Task.create!(title: "First Task") }
  let(:id) { task.id }
  let(:valid_attributes) {
    { data: { id: nil, attributes: { title: "First Task" }, tags: ["Today"] } }
  }

  # Test suite for GET /api/v1/tasks
  describe "GET /api/v1/tasks" do
    before { get api_v1_tasks_path }

    it "returns tasks" do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/v1/tasks/1
  describe "GET /api/v1/tasks/:id" do
    before { get api_v1_tasks_path }

    it "returns task" do
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for POST /api/v1/tasks
  describe "POST /api/v1/tasks" do
    context "when request is valid" do
      before { post api_v1_tasks_path, params: valid_attributes }

      it "creates a task" do
        expect(json['data']['attributes']['title']).to eq("First Task")
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  # Test suite for PATCH /api/v1/tasks
  describe "PATCH /api/v1/tasks/:id" do
    before { patch api_v1_task_path(id: id), params: valid_attributes }

    context "when the record exists" do
      it "updates the record with title field" do
        updated_task = Task.find(id)
        expect(updated_task.title).to eq("First Task")
      end
      it "returns status code 204" do
        expect(response).to have_http_status(200)
      end
    end

    context "when record does not exist" do
      let(:id) { 0 }
      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end
      it "returns a not found message" do
        expect(response.body).to match(/Record was not found/)
      end
    end
  end

  # Test suite for DELETE /api/v1/tasks/1
  describe "DELETE /api/v1/tasks/:id" do
    before { delete api_v1_task_path(id: id) }

    it "returns status code 204" do
      expect(response).to have_http_status(204)
    end
  end

end
