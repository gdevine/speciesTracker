class Species < ActiveRecord::Base

  has_many :sightings, :class_name => 'Sighting', :foreign_key => 'species_id', :dependent => :restrict_with_exception

  validates :genus, :presence => { :message => "A genus is required" }, length: { maximum: 80 }
  validates :species, :presence => { :message => "A species is required" }, length: { maximum: 80 }
  validates :genus, :uniqueness => {:scope => [:species], message: "This genus-species already exists"}
  
  def fullname
    self.genus << " " << self.species
  end
  
end
