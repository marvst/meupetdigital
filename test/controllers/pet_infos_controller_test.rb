require "test_helper"

class PetInfosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pet_infos_index_url
    assert_response :success
  end

  test "should get new" do
    get pet_infos_new_url
    assert_response :success
  end

  test "should get create" do
    get pet_infos_create_url
    assert_response :success
  end

  test "should get edit" do
    get pet_infos_edit_url
    assert_response :success
  end

  test "should get update" do
    get pet_infos_update_url
    assert_response :success
  end

  test "should get destroy" do
    get pet_infos_destroy_url
    assert_response :success
  end
end
