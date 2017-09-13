require 'test_helper'

class Manage::ProductCompaniesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @manage_product_company = manage_product_companies(:one)
  end

  test "should get index" do
    get manage_product_companies_url
    assert_response :success
  end

  test "should get new" do
    get new_manage_product_company_url
    assert_response :success
  end

  test "should create manage_product_company" do
    assert_difference('Manage::ProductCompany.count') do
      post manage_product_companies_url, params: { manage_product_company: {  } }
    end

    assert_redirected_to manage_product_company_url(Manage::ProductCompany.last)
  end

  test "should show manage_product_company" do
    get manage_product_company_url(@manage_product_company)
    assert_response :success
  end

  test "should get edit" do
    get edit_manage_product_company_url(@manage_product_company)
    assert_response :success
  end

  test "should update manage_product_company" do
    patch manage_product_company_url(@manage_product_company), params: { manage_product_company: {  } }
    assert_redirected_to manage_product_company_url(@manage_product_company)
  end

  test "should destroy manage_product_company" do
    assert_difference('Manage::ProductCompany.count', -1) do
      delete manage_product_company_url(@manage_product_company)
    end

    assert_redirected_to manage_product_companies_url
  end
end
