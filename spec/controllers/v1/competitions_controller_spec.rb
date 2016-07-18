require "rails_helper"

RSpec.describe V1::CompetitionsController, type: :controller do
  describe "#index" do
    it "returns all competitions with all attributes as JSON" do
      5.times { create(:competition) }

      get :index

      expected_body = Competition.all.to_json
      expect(response.body).to eq expected_body
    end

    it "returns 200" do
      get :index

      expect(response).to have_http_status(200)
    end
  end

  describe "#create" do
    context "competition is valid" do
      it "creates competition" do
        challenger = 1
        challenged = 2

        post(
          :create,
          params: permitted_params(challenger: challenger, challenged: challenged)
        )

        expect(Competition.all.count).to eq 1
        expect(Competition.first.challenger).to eq challenger
        expect(Competition.first.challenged).to eq challenged
      end

      it "returns 201" do
        post :create, params: permitted_params

        expect(response).to have_http_status(201)
      end

      it "returns the location of the newly created competition" do
        post :create, params: permitted_params

        created_competition = Competition.first
        expect(response.location).to eq v1_competition_url(created_competition)
      end
    end

    context "competition is NOT valid" do
      it "does NOT create competition" do
        stub_invalid_competition_for_create
        post :create, params: permitted_params

        expect(Competition.all.count).to eq 0
      end

      it "returns 422" do
        stub_invalid_competition_for_create
        post :create, params: permitted_params

        expect(response).to have_http_status(422)
      end
    end
  end

  describe "#show" do
    context "competition exists" do
      it "returns competition" do
        competition = create(:competition)

        get :show, params: { id: competition.id }

        expect(response.body).to eq competition.to_json
      end

      it "returns 200" do
        competition = create(:competition)

        get :show, params: { id: competition.id }

        expect(response).to have_http_status(200)
      end
    end

    context "competition does NOT exist" do
      it "returns 404" do
        non_existent_competition_id = 1

        get :show, params: { id: non_existent_competition_id }

        expect(response).to have_http_status(404)
      end
    end
  end

  def permitted_params(challenger: 1, challenged: 2)
    { competition: { challenger: challenger, challenged: challenged } }
  end

  def stub_invalid_competition_for_create
    invalid_competition = double(:invalid_competition, save: false, errors: [])
    allow(Competition).to receive(:new).and_return(invalid_competition)
  end
end
