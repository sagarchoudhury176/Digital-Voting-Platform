class Election < ApplicationRecord
  has_many :nominations
  has_many :votes
  has_many :candidates, through: :nominations

  after_create do
    # Initialize a empty vote count
    Vote.create_genesis_vote(id)
    self.vote_count = {}
    save
  end

  def self.finished
    select { |election| election.voting_over? }
  end

  def nominations_over?
    deadline < DateTime.now
  end

  def voting_over?
    end_time < DateTime.now
  end

  def in_progress?
    DateTime.now.between?(start_time, end_time)
  end

  def nominate(candidate_id)
    Nomination.create(election: self, candidate_id: candidate_id)
    vote_count[candidate_id] = 0
    save
  end

  def vote(voter_id, candidate_id)
    Vote.add_vote(voter_id, candidate_id, id, votes.last)
    vote_count[candidate_id.to_s] += 1
    save
  end

  def winner
    Candidate.find(vote_count.max_by{ |k,v| v }[0])
  end
  
  def to_csv
    require 'csv'
    attributes = %w[hash prev_hash candidate_id]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      votes.each do |vote|
        if vote.vote
          csv << [vote.data, vote.vote.data, vote.candidate_id]
        else
          csv << [vote.data, nil, vote.candidate_id]
        end
      end
    end
  end
end
