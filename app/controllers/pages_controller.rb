class PagesController < ApplicationController
  def ledger
    respond_to do |format|
      format.html
      format.csv do
        election = Election.find(params[:election])
        send_data election.to_csv, filename: "#{election.position}-ledger.csv"
      end
    end
  end
end
