class Candidate < ApplicationRecord
  belongs_to :user
  has_many :nominations
  has_many :elections, through: :nominations

  ATTR_METHODS = Array.new
  attribute_names.reject { |val| %w[id created_at updated_at].include?(val) }
    .each do |val|
    ATTR_METHODS << val.to_sym
    ATTR_METHODS << "#{val}=".to_sym
  end

  delegate *User::ATTR_METHODS, to: :user
  delegate *UserDetail::ATTR_METHODS, to: :user

  PARTIES = [
    "Democratic Party",
    "Republican Party",
    "Socialist Party",
    "Libertarian Party",
    "Nationalist Party"
  ]
end
