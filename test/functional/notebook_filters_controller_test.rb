require 'test_helper'

class NotebookFiltersControllerTest < ActionController::TestCase
  setup do
    @notebook_filter = notebook_filters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:notebook_filters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create notebook_filter" do
    assert_difference('NotebookFilter.count') do
      post :create, notebook_filter: { cpu: @notebook_filter.cpu, harddisk: @notebook_filter.harddisk, keyword: @notebook_filter.keyword, price: @notebook_filter.price, screen: @notebook_filter.screen }
    end

    assert_redirected_to notebook_filter_path(assigns(:notebook_filter))
  end

  test "should show notebook_filter" do
    get :show, id: @notebook_filter
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @notebook_filter
    assert_response :success
  end

  test "should update notebook_filter" do
    put :update, id: @notebook_filter, notebook_filter: { cpu: @notebook_filter.cpu, harddisk: @notebook_filter.harddisk, keyword: @notebook_filter.keyword, price: @notebook_filter.price, screen: @notebook_filter.screen }
    assert_redirected_to notebook_filter_path(assigns(:notebook_filter))
  end

  test "should destroy notebook_filter" do
    assert_difference('NotebookFilter.count', -1) do
      delete :destroy, id: @notebook_filter
    end

    assert_redirected_to notebook_filters_path
  end
end
