class Species < ActiveRecord::Base

  validates :genus, :presence => { :message => "A genus is required" }, length: { maximum: 80 }
  validates :species, :presence => { :message => "A species is required" }, length: { maximum: 80 }
  validates :genus, :uniqueness => {:scope => [:species], message: "This genus-species already exists"}
  
end
