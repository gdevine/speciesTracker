class StaticPagesController < ApplicationController
  # authorize_resource class: false
  authorize_resource :class => StaticPagesController
  
  def home
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
  
  
  # The following pages are for testing purposes only
  def useronlypage
  end
  
  def superuseronlypage
  end

  def adminonlypage
  end
    
end
