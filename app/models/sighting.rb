class Sighting < ActiveRecord::Base
  
  belongs_to :species, :class_name => 'Species', :foreign_key => 'species_id'
  belongs_to :site, :class_name => 'Site', :foreign_key => 'site_id'
  belongs_to :creator, :class_name => 'User', :foreign_key => 'creator_id'
  belongs_to :spotter, :class_name => 'User', :foreign_key => 'spotter_id'
  
  ## Validations
  validates :site_id, :presence => { :message => "You must select a Site" }
  validates :species_id, :presence => { :message => "You must select a Species" }
  validates :creator_id, presence: true
  validates :spotter_id, presence: true
  validates :datetime_sighted, :presence => { :message => "You must state when a sighting was made" }
  
  validates :latitude, :numericality => { :greater_than_or_equal_to => -90.0, :less_than_or_equal_to => 90 }, :allow_nil => true
  validates :longitude, :numericality => { :greater_than_or_equal_to => 0.0, :less_than_or_equal_to => 360.0 }, :allow_nil => true
  validates :altitude, :numericality => { :greater_than_or_equal_to => 0.0, :less_than_or_equal_to => 10000.0 }, :allow_nil => true
  
  #custom validations
  validate :check_future_sighting
  validate :validate_species_id
  validate :validate_site_id
  validate :validate_spotter_id
  validate :validate_creator_id
  validate :creator_spotter_same_if_user
  validate :date_is_date?
  
  
  private
  
  def check_future_sighting
    if !self.datetime_sighted.nil?
      errors.add(:base, "Date/Time of sighting can not be in the future") if self.datetime_sighted > Time.now + 1.day
    end
  end  
  
  def validate_species_id
    if !self.species_id.nil?
      errors.add(:species_id, "Species given is invalid") unless Species.exists?(self.species_id)
    end
  end

  def validate_site_id
    if !self.site_id.nil?
      errors.add(:site_id, "Site given is invalid") unless Site.exists?(self.site_id)
    end
  end

  def validate_spotter_id
    errors.add(:spotter_id, "is invalid") unless User.exists?(self.spotter_id)
  end

  def validate_creator_id
    errors.add(:creator_id, "is invalid") unless User.exists?(self.creator_id)
  end

  def creator_spotter_same_if_user
    if !self.creator_id.nil? && User.exists?(self.creator_id) && !self.spotter_id.nil? && User.exists?(self.spotter_id) 
      if self.creator.role == "user"
        errors.add(:base, "A creator can not be different to spotter when creator is user") if self.creator != self.spotter
      end
    end
  end 
  
  def date_is_date?
    if !self.datetime_sighted.nil?
      if !self.datetime_sighted.to_datetime.is_a?(DateTime)
        errors.add(:datetime_sighted, 'must be a valid date/time') 
      end
    end
  end
  
    
end
