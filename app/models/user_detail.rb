class UserDetail < ApplicationRecord
  belongs_to :user

  ATTR_METHODS = Array.new
  attribute_names.reject{ |val| %w[id name created_at updated_at].include?(val) }
    .each do |val|
    ATTR_METHODS << val.to_sym
    ATTR_METHODS << "#{val}=".to_sym
  end

  DEPARTMENTS = [
    "Computer Science And Engineering",
    "Information Technology",
    "Electrical And Communications Engineering",
    "Electrical And Electronics Engineering",
    "Mechanical Engineering",
    "Civil Engineering",
    "Mining"
  ]

  COURSES = [
    "B. Tech",
    "M. Tech",
    "M.C.A.",
    "M.B.A.",
    "Ph.D."
  ]
end
