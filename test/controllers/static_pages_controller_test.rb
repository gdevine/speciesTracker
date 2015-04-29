require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "Species Tracker | Home"
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "Species Tracker | Help"
  end
 
  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "Species Tracker | About"
  end 
  
  test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", "Species Tracker | Contact"
  end
  

end
