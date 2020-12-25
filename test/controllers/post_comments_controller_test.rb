require 'test_helper'

class PostCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get post_comments_create_url
    assert_response :success
  end

end
