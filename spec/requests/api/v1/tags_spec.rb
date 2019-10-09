require 'rails_helper'

RSpec.describe "Api::V1::Tags", type: :request do

  let(:tag) { Tag.create!(title: "Today") }
  let(:id) { tag.id }
  let(:valid_attributes) {
    { data: { id: nil, attributes: { title: "Today" } } }
  }

  # Test suite for GET /api/v1/tags
  describe "GET /api/v1/tags" do
    before { get api_v1_tags_path }

    it "returns tags" do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for POST /api/v1/tags
  describe "POST /api/v1/tags" do
    context "when request is valid" do
      before { post api_v1_tags_path, params: valid_attributes }

      it "creates a tag" do
        expect(json['data']['attributes']['title']).to eq("Today")
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  # Test suite for PATCH /api/v1/tags
  describe "PATCH /api/v1/tags/:id" do
    before { patch api_v1_tag_path(id: id), params: valid_attributes }

    context "when the record exists" do
      it "updates the record with title field" do
        updated_tag = Tag.find(id)
        expect(updated_tag.title).to eq("Today")
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

end
