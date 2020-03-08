class Nomination < ApplicationRecord
  belongs_to :candidate
  belongs_to :election
end
