class CandidatesController < ApplicationController
  load_and_authorize_resource
  before_action :set_candidate, only: [:show]
  def index
  end

  def show
  end

  private

  def set_candidate
    @candidate = Candidate.find(params[:id])
  end
end
