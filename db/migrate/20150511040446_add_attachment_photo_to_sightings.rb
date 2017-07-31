class AddAttachmentPhotoToSightings < ActiveRecord::Migration[5.0]
  def self.up
    change_table :sightings do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :sightings, :photo
  end
end
