require 'test_helper'

class CompaniesControllerTest < ActionController::TestCase
  setup do
    @association = Association.find(1)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:associations)
  end



  test "should create association" do
    assert_difference('Association.count') do
      post :create, association: { iban: @association.iban, bank_name: @association.bank_name, city: @association.city, email: @association.email, association_board: @association.association_board, association_name: @association.association_name, county_court: @association.county_court, association_register: @association.association_register, name: @association.name, street: @association.street, verein_name: @association.verein_name, web: @association.web, zip_code: @association.zip_code }
    end

    assert_redirected_to association_path(assigns(:association))
  end

  test "should show association" do
    get :show, id: @association
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @association
    assert_response :success
  end

  test "should update association" do
    put :update, id: @association, association: { iban: @association.iban, bank_name: @association.bank_name, city: @association.city, email: @association.email, association_board: @association.association_board, association_name: @association.association_name, county_court: @association.county_court, association_register: @association.association_register, name: @association.name, street: @association.street, verein_name: @association.verein_name, web: @association.web, zip_code: @association.zip_code }
    assert_redirected_to association_path(assigns(:association))
  end

  test "should destroy association" do
    assert_difference('Association.count', -1) do
      delete :destroy, id: @association
    end

    assert_redirected_to associations_path
  end
end
