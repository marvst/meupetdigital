class UpdatePetInfosToSupportMultipleChannels < ActiveRecord::Migration[8.0]
  def up
    # Add channels column
    add_column :pets_infos, :channels, :text
    
    # Migrate existing channel data to channels array
    execute <<-SQL
      UPDATE pets_infos 
      SET channels = JSON_ARRAY(channel)
      WHERE channel IS NOT NULL
    SQL
    
    # Remove old channel column
    remove_column :pets_infos, :channel
  end
  
  def down
    # Add back channel column
    add_column :pets_infos, :channel, :string
    
    # Migrate channels array back to single channel (take first one)
    execute <<-SQL
      UPDATE pets_infos 
      SET channel = JSON_UNQUOTE(JSON_EXTRACT(channels, '$[0]'))
      WHERE channels IS NOT NULL
    SQL
    
    # Remove channels column
    remove_column :pets_infos, :channels
  end
end
