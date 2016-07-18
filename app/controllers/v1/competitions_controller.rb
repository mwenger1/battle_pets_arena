module V1
  class CompetitionsController < ApplicationController
    ERROR_MESSAGE_404 = "record not found"

    before_action :set_competition, only: [:show]

    def index
      @competitions = Competition.all

      render json: @competitions
    end

    def show
      render json: @competition
    end

    def create
      @competition = Competition.new(competition_params)

      if @competition.save
        render json: @competition, status: :created, location: v1_competition_url(@competition)
      else
        render json: @competition.errors, status: :unprocessable_entity
      end
    end

    private

    def set_competition
      @competition = Competition.find(competition_id)
    rescue ActiveRecord::RecordNotFound
      render json: {error: ERROR_MESSAGE_404, status: 404}, status: 404
    end

    def competition_id
      params.require(:id)
    end

    def competition_params
      params.require(:competition).permit(:challenger, :challenged)
    end
  end
end
