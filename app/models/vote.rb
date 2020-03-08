class Vote < ApplicationRecord
  belongs_to :election
  belongs_to :candidate, optional: true
  belongs_to :user, optional: true
  belongs_to :vote, optional: true

  # Proof Of Work Function - Whether hash contains candidate id as substring

  def self.create_genesis_vote(election_id)
    sha = Digest::SHA256.new
    sha.update(election_id.to_s)
    Vote.create(data: sha, election_id: election_id)
  end

  def self.add_vote(voter_id, candidate_id, election_id, prev_vote)
    sha = Digest::SHA256.new
    data = prev_vote.data || ''
    loop do
      sha.update(
        data.to_s + voter_id.to_s + candidate_id.to_s + election_id.to_s +
        prev_vote.created_at.to_s + prev_vote.updated_at.to_s
      )

      if proof_of_work(sha, candidate_id)
        return Vote.create(
          data: sha,
          user_id: voter_id,
          candidate_id: candidate_id,
          election_id: election_id,
          vote_id: prev_vote.id
        )
      end
    end
  end

  private

  def self.proof_of_work(sha, data)
    sha.hexdigest.include? data.to_s
  end
end
