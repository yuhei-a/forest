require 'test_helper'

class UnlikesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get unlikes_create_url
    assert_response :success
  end

end
