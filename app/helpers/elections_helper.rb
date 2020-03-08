module ElectionsHelper
  def voted(election_id)
    election = Election.find(election_id)
    current_user && election.votes.pluck(:user_id).include?(current_user.id)
  end

  def candidates_panel_partial_path(election)
    if election.voting_over?
      'candidate_vote_count'
    else
      'candidates'
    end
  end

  def percent(numerator, denominator)
    (numerator.to_f/denominator)*100
  end
end
