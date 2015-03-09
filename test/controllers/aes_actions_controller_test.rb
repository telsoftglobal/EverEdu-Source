require 'test_helper'

class AesActionsControllerTest < ActionController::TestCase
  # test "should get edit" do
  #   get :edit
  #   assert_response :success
  # end
  # setup do
  #   @aes_action = aes_actions(:one)
  # end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:aes_actions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create aes_action" do
    assert_difference('AesAction.count') do
      post :create, aes_action: {  }
    end

    assert_redirected_to aes_action_path(assigns(:aes_action))
  end

  test "should show aes_action" do
    get :show, id: @aes_action
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @aes_action
    assert_response :success
  end

  test "should update aes_action" do
    patch :update, id: @aes_action, aes_action: {  }
    assert_redirected_to aes_action_path(assigns(:aes_action))
  end

  test "should destroy aes_action" do
    assert_difference('AesAction.count', -1) do
      delete :destroy, id: @aes_action
    end

    assert_redirected_to aes_actions_path
  end

  #===============================================CuongCT TDD Update Material==========================================================
  #===============================================       SUCCESS             ==========================================================
  # Description: update action full information
  # @author: CuongCT
  # Create Date: 18/12/2014
  # Modify Date:
  test 'update action full information' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'
    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    action = Action.first
    patch  :quickupdate, :aes_action => {:id=>action.id,:action_name => 'update'+strTime,:description => 'this is description' + strTime}, format: :js
    assert_not flash[:error]
  end

  #===============================================       FAILED              ==========================================================
  #===============================================       EMPTY               ==========================================================
  # Description: update empty action name
  # @author: CuongCT
  # Create Date: 18/12/2014
  # Modify Date:
  test 'update empty action name ' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'
    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    action = Action.first
    # get :edit, curriculum

    patch :quickupdate, :aes_action => { :id=>action.id, :description => 'this is description' + strTime}, format: :js
    assert flash[:error]
    puts flash[:error]
  end

  #===============================================       FAILED              ==========================================================
  #===============================================       MAXLENGTH           ==========================================================
  # Description: update action name maxlength
  # @author: CuongCT
  # Create Date: 18/12/2014
  # Modify Date:
  test 'update action name maxlength' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'
    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    action = Action.first
    # get :edit, curriculum
    action_name = ""
    for i in 0..101
      action_name = action_name + 'i'
    end
    patch :quickupdate, :aes_action => { :id=>action.id,:action_name => action_name, :description => 'this is description' + strTime}, format: :js
    assert flash[:error]
    puts flash[:error]
  end

  # Description: update material description maxlength
  # @author: CuongCT
  # Create Date: 18/12/2014
  # Modify Date:
  test 'update material description maxlength' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'
    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    action = Action.first
    # get :edit, curriculum
    description = "http://google.com/"
    for i in 0..10001
      description = description + 'i'
    end
    patch :quickupdate, :aes_action => { :id=>action.id,:action_name => 'action_name',:description => description}, format: :js
    assert flash[:error]
    puts flash[:error]
  end

end
