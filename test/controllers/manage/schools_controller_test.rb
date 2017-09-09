require 'test_helper'

class Manage::SchoolsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @manage_school = manage_schools(:one)
  end

  test "should get index" do
    get manage_schools_url
    assert_response :success
  end

  test "should get new" do
    get new_manage_school_url
    assert_response :success
  end

  test "should create manage_school" do
    assert_difference('Manage::School.count') do
      post manage_schools_url, params: { manage_school: { cate: @manage_school.cate, city: @manage_school.city, info: @manage_school.info, name: @manage_school.name, sign: @manage_school.sign } }
    end

    assert_redirected_to manage_school_url(Manage::School.last)
  end

  test "should show manage_school" do
    get manage_school_url(@manage_school)
    assert_response :success
  end

  test "should get edit" do
    get edit_manage_school_url(@manage_school)
    assert_response :success
  end

  test "should update manage_school" do
    patch manage_school_url(@manage_school), params: { manage_school: { cate: @manage_school.cate, city: @manage_school.city, info: @manage_school.info, name: @manage_school.name, sign: @manage_school.sign } }
    assert_redirected_to manage_school_url(@manage_school)
  end

  test "should destroy manage_school" do
    assert_difference('Manage::School.count', -1) do
      delete manage_school_url(@manage_school)
    end

    assert_redirected_to manage_schools_url
  end
end
