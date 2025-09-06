class User < ApplicationRecord
  has_many :pets, dependent: :destroy
  has_many :auth_tokens, dependent: :destroy
  has_many :pet_users, dependent: :destroy
  has_many :shared_pets, through: :pet_users, source: :pet
  has_many :pet_infos, foreign_key: :created_by_id, dependent: :destroy
  
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true
  
  def self.find_by_email(email)
    where('LOWER(email) = ?', email.downcase.strip).first
  end
  
  def all_pets
    Pet.where(id: pets.pluck(:id) + shared_pets.pluck(:id)).distinct
  end
end
