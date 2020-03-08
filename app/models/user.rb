class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :user_detail, dependent: :destroy
  has_one :candidate, dependent: :destroy
  has_many :votes

  ATTR_METHODS = Array.new
  attribute_names.reject { |val| %w[id created_at updated_at].include?(val) }
    .each do |val|
    ATTR_METHODS << val.to_sym
    ATTR_METHODS << "#{val}=".to_sym
  end

  delegate *UserDetail::ATTR_METHODS, to: :user_detail
  delegate *Candidate::ATTR_METHODS, to: :candidate

  def is?(requested_role)
    return candidate if requested_role == 'candidate'
    return admin if requested_role == 'admin'
    return id if requested_role == 'user'
  end
end
