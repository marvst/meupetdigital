class PetInfo < ApplicationRecord
  self.table_name = 'pets_infos'
  
  belongs_to :pet
  belongs_to :created_by, class_name: 'User'
  
  validates :channels, presence: true
  validates :name, presence: true
  validates :value, presence: true
  
  CHANNELS = %w[phone whatsapp email telegram instagram facebook].freeze
  
  def self.channels
    CHANNELS
  end
  
  # Handle channels as JSON array
  def channels
    if self[:channels].is_a?(String)
      JSON.parse(self[:channels])
    else
      self[:channels] || []
    end
  end
  
  def channels=(value)
    self[:channels] = value.is_a?(Array) ? value.to_json : value
  end
  
  def display_value
    case channels.first
    when 'phone', 'whatsapp'
      value
    when 'email'
      value
    when 'telegram'
      "@#{value}"
    when 'instagram'
      "@#{value}"
    when 'facebook'
      value
    else
      value
    end
  end
  
  def channel_labels
    channels.map(&:humanize).join(', ')
  end
end
