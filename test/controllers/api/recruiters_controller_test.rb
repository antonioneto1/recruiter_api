require 'test_helper'

class RecruitersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recruiter = recruiters(:one)
  end

  test "should get index" do
    get recruiters_url
    assert_response :success
  end

  test "should get new" do
    get new_recruiter_url
    assert_response :success
  end

  test "should create recruiter" do
    assert_difference('Recruiter.count') do
      post recruiters_url, params: { recruiter: { email: @recruiter.email, name: @recruiter.name, password: @recruiter.password } }
    end

    assert_redirected_to recruiter_url(Recruiter.last)
  end

  test "should show recruiter" do
    get recruiter_url(@recruiter)
    assert_response :success
  end

  test "should get edit" do
    get edit_recruiter_url(@recruiter)
    assert_response :success
  end

  test "should update recruiter" do
    patch recruiter_url(@recruiter), params: { recruiter: { email: @recruiter.email, name: @recruiter.name, password: @recruiter.password } }
    assert_redirected_to recruiter_url(@recruiter)
  end

  test "should destroy recruiter" do
    assert_difference('Recruiter.count', -1) do
      delete recruiter_url(@recruiter)
    end

    assert_redirected_to recruiters_url
  end
end
