class Pet < ApplicationRecord
  belongs_to :user
  has_many :pet_users, dependent: :destroy
  has_many :users, through: :pet_users
  has_many :pet_infos, dependent: :destroy
  
  validates :name, presence: true
  validates :species, presence: true
  validates :breed, presence: true
  validates :uuid, presence: true, uniqueness: true
  
  before_validation :generate_uuid, on: :create
  
  def self.find_by_uuid(uuid)
    find_by(uuid: uuid)
  end
  
  def owner
    user
  end
  
  def shared_users
    users.where.not(id: user_id)
  end
  
  def accessible_by?(user)
    user_id == user.id || users.include?(user)
  end
  
  private
  
  def generate_uuid
    self.uuid = SecureRandom.uuid if uuid.blank?
  end
end
