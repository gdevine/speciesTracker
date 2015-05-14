module ApplicationHelper
  
  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Species Tracker"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  
  def to_twodp(num)
    # Returns a float number to two decimal places
    number_with_precision(num, :precision => 2).to_s
  end
    
end
