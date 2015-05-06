class Site < ActiveRecord::Base
  
  has_many :sightings, :class_name => 'Sighting', :foreign_key => 'site_id', :dependent => :restrict_with_exception
  
  validates :name, :uniqueness => {:message => "This name already exists"}, :presence => { :message => "A name is required" }, length: { maximum: 80 }
  validates :street, length: { maximum: 80 }
  validates :suburb, :presence => { :message => "A suburb is required" }, length: { maximum: 80 }
  validates :centre_lat, :numericality => { :greater_than_or_equal_to => -90.0, :less_than_or_equal_to => 90 }
  validates :centre_lon, :numericality => { :greater_than_or_equal_to => 0.0, :less_than_or_equal_to => 360.0 }
  validates :centre_alt, :numericality => { :greater_than_or_equal_to => 0.0, :less_than_or_equal_to => 10000.0 }
  
end
