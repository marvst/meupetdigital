class PetUser < ApplicationRecord
  belongs_to :pet
  belongs_to :user
  
  validates :role, presence: true
  validates :user_id, uniqueness: { scope: :pet_id }
  
  ROLES = %w[owner admin member viewer].freeze
  
  def self.roles
    ROLES
  end
  
  def can_edit?
    %w[owner admin].include?(role)
  end
  
  def can_delete?
    role == 'owner'
  end
end
