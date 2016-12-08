require 'test_helper'

class ContractsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contract = contracts(:one)
  end

  test "should get index" do
    get contracts_url
    assert_response :success
  end

  test "should get new" do
    get new_contract_url
    assert_response :success
  end

  test "should create contract" do
    assert_difference('Contract.count') do
      post contracts_url, params: { contract: { atipogente: @contract.atipogente, campaing_id: @contract.campaing_id, commission: @contract.commission, coowner: @contract.coowner, date: @contract.date, legal_representative: @contract.legal_representative, mail: @contract.mail, membership: @contract.membership, membership_number: @contract.membership_number, membership_size: @contract.membership_size, membership_type: @contract.membership_type, number_weeks: @contract.number_weeks, owner: @contract.owner, portfolio_number: @contract.portfolio_number, price_rent: @contract.price_rent, price_week: @contract.price_week, season: @contract.season, sell_price: @contract.sell_price, type: @contract.type, user_id: @contract.user_id } }
    end

    assert_redirected_to contract_url(Contract.last)
  end

  test "should show contract" do
    get contract_url(@contract)
    assert_response :success
  end

  test "should get edit" do
    get edit_contract_url(@contract)
    assert_response :success
  end

  test "should update contract" do
    patch contract_url(@contract), params: { contract: { atipogente: @contract.atipogente, campaing_id: @contract.campaing_id, commission: @contract.commission, coowner: @contract.coowner, date: @contract.date, legal_representative: @contract.legal_representative, mail: @contract.mail, membership: @contract.membership, membership_number: @contract.membership_number, membership_size: @contract.membership_size, membership_type: @contract.membership_type, number_weeks: @contract.number_weeks, owner: @contract.owner, portfolio_number: @contract.portfolio_number, price_rent: @contract.price_rent, price_week: @contract.price_week, season: @contract.season, sell_price: @contract.sell_price, type: @contract.type, user_id: @contract.user_id } }
    assert_redirected_to contract_url(@contract)
  end

  test "should destroy contract" do
    assert_difference('Contract.count', -1) do
      delete contract_url(@contract)
    end

    assert_redirected_to contracts_url
  end
end
