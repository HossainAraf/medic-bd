require 'test_helper'

class Api::V1::FeedbackFormsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get api_v1_feedback_forms_index_url
    assert_response :success
  end

  test 'should get create' do
    get api_v1_feedback_forms_create_url
    assert_response :success
  end

  test 'should get update' do
    get api_v1_feedback_forms_update_url
    assert_response :success
  end
end
