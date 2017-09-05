require 'test_helper'

class Manage::CarouselsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @manage_carousel = manage_carousels(:one)
  end

  test "should get index" do
    get manage_carousels_url
    assert_response :success
  end

  test "should get new" do
    get new_manage_carousel_url
    assert_response :success
  end

  test "should create manage_carousel" do
    assert_difference('Manage::Carousel.count') do
      post manage_carousels_url, params: { manage_carousel: { image: @manage_carousel.image, index: @manage_carousel.index, link: @manage_carousel.link, show: @manage_carousel.show } }
    end

    assert_redirected_to manage_carousel_url(Manage::Carousel.last)
  end

  test "should show manage_carousel" do
    get manage_carousel_url(@manage_carousel)
    assert_response :success
  end

  test "should get edit" do
    get edit_manage_carousel_url(@manage_carousel)
    assert_response :success
  end

  test "should update manage_carousel" do
    patch manage_carousel_url(@manage_carousel), params: { manage_carousel: { image: @manage_carousel.image, index: @manage_carousel.index, link: @manage_carousel.link, show: @manage_carousel.show } }
    assert_redirected_to manage_carousel_url(@manage_carousel)
  end

  test "should destroy manage_carousel" do
    assert_difference('Manage::Carousel.count', -1) do
      delete manage_carousel_url(@manage_carousel)
    end

    assert_redirected_to manage_carousels_url
  end
end
