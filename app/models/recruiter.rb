class Recruiter < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :jobs

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
end
