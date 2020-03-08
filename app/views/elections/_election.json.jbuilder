json.extract! election, :id, :position, :deadline, :start, :end, :session, :vote_count, :candidate_id, :created_at, :updated_at
json.url election_url(election, format: :json)
