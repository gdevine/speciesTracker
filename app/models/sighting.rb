class Sighting < ActiveRecord::Base

  belongs_to :species, :class_name => 'Species', :foreign_key => 'species_id'
  belongs_to :site, :class_name => 'Site', :foreign_key => 'site_id'
  belongs_to :creator, :class_name => 'User', :foreign_key => 'creator_id'
  belongs_to :spotter, :class_name => 'User', :foreign_key => 'spotter_id'

  # For photo uploads via paperclip
  has_attached_file :photo,
    :styles => { large: "800x800>", medium: "250x250>", thumb: "100x100#" },
    # :path => "sightings/:id/:attachment/:fingerprint-:style.:extension",
    :default_url => "/images/:style/missing.png",
    :url => "/assets/photos/:style/:normalize_basename.:extension",
    :path => ":rails_root/public/assets/photos/:style/:normalize_basename.:extension"

    Paperclip.interpolates :normalize_basename do |attachment, style|
      attachment.instance.normalize_basename
    end


    def normalize_basename
      'species_photo_'+self.id.to_s
    end


  ## Validations
  validates :species_id, :presence => { :message => "You must select a Species" }
  validates :creator_id, presence: true
  validates :spotter_id, presence: true
  validates :dom_reproductive_stage, :presence => { :message => "You must select a Dominant Reproductive Stage" }
  validates :datetime_sighted, :presence => { :message => "You must state when a sighting was made" }

  validates :latitude, :numericality => { :greater_than_or_equal_to => -90.0, :less_than_or_equal_to => 90 }, :allow_nil => true
  validates :longitude, :numericality => { :greater_than_or_equal_to => 0.0, :less_than_or_equal_to => 360.0 }, :allow_nil => true
  validates :altitude, :numericality => { :greater_than_or_equal_to => 0.0, :less_than_or_equal_to => 10000.0 }, :allow_nil => true

  # For photo uploads via paperclip
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/, message: "This is not a valid photograph format"
  validates_with AttachmentSizeValidator, :attributes => :photo, :less_than => 5.megabytes, :message => "Photo uploads must be less than 5Mb  "

  #custom validations
  validate :site_andor_coords
  validate :check_future_sighting
  validate :validate_species_id
  validate :validate_site_id
  validate :validate_spotter_id
  validate :validate_creator_id
  validate :creator_spotter_same_if_user
  validate :valid_dom_reproductive_stage
  validate :date_is_date?


  def primary_lat
    if self.latitude.nil?
      self.site.centre_lat
    else
      self.latitude
    end
  end

  def primary_lon
    if self.longitude.nil?
      self.site.centre_lon
    else
      self.longitude
    end
  end


  private

  def site_andor_coords
    if (!self.latitude.nil? && self.longitude.nil? ) || (!self.longitude.nil? && self.latitude.nil? )
      errors.add(:base, "If providing latitude/longitude, both must be present")
    elsif self.site.nil?
      errors.add(:base, "If a research site is not selected, then a specific latitude/longitude must be given") if self.latitude.nil? || self.longitude.nil?
    end
  end

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
      errors.add(:site_id, "Research Site given is invalid") unless Site.exists?(self.site_id)
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

  def valid_dom_reproductive_stage
    if !self.dom_reproductive_stage.blank?
      if !Settings.dom_reproductive_stage.include?(self.dom_reproductive_stage)
        errors.add(:base, "This is not a valid choice for Dominant Reproductive Stage")
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
