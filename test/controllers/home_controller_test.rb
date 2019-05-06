require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest

  #def setup
  #  @title = "<% yield(:title) %>"
  #end

  test "should get top" do
    get root_url
    assert_response :success
    #assert_select "title","#{@title}"
    assert_select "title","Webアクアリウム"
  end

end
