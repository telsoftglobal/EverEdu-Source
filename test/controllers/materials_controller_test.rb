require 'test_helper'

class MaterialsControllerTest < ActionController::TestCase
  # test "should get edit" do
  #   get :edit
  #   assert_response :success
  # end

  # setup do
  #   @material = materials(:one)
  # end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:materials)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create material" do
    assert_difference('Material.count') do
      post :create, material: {  }
    end

    assert_redirected_to material_path(assigns(:material))
  end

  test "should show material" do
    get :show, id: @material
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @material
    assert_response :success
  end

  test "should update material" do
    patch :update, id: @material, material: {  }
    assert_redirected_to material_path(assigns(:material))
  end

  test "should destroy material" do
    assert_difference('Material.count', -1) do
      delete :destroy, id: @material
    end

    assert_redirected_to materials_path
  end

  #===============================================CuongCT TDD Update Material==========================================================
  #===============================================       SUCCESS             ==========================================================
  # Description: update material full information
  # @author: CuongCT
  # Create Date: 18/12/2014
  # Modify Date:
  test 'update material full information' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'
    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    material = Material.first
    material_type = MaterialType.find_by(id: 'book')
    # get :edit, curriculum
    patch :quickupdate, id: material.id,:material => { :id=>material.id, :material_name => 'update'+strTime,:material_url => 'http://google.com', :material_type_id => material_type.id,:description => 'this is description' + strTime}, format: :js
    assert_not flash[:error]
  end

  # Description: update material name and material type
  # @author: CuongCT
  # Create Date: 18/12/2014
  # Modify Date:
  test 'update material name and material type' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'
    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    material = Material.first
    material_type = MaterialType.find_by(id: 'book')
    # get :edit, curriculum

    patch :update,id: material.id, :id=>material.id, :material => {:material_name => 'update'+strTime,:material_type_id => material_type.id}, format: :js
    assert_not flash[:error]
  end

  # Description: update material url
  # @author: CuongCT
  # Create Date: 18/12/2014
  # Modify Date:
  test 'update material url' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'
    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    material = Material.first
    material_type = MaterialType.find_by(id: 'book')
    # get :edit, curriculum

    patch :quickupdate,id: material.id, :material => { :id=>material.id, :material_name => 'update'+strTime,:material_url => 'http://google.comcc', :material_type_id => material_type.id,:description => 'this is description' + strTime}, format: :js
    assert_not flash[:error]
  end

  #===============================================       FAILED              ==========================================================
  #===============================================       EMPTY               ==========================================================
  # Description: update empty material name
  # @author: CuongCT
  # Create Date: 18/12/2014
  # Modify Date:
  test 'update empty material name ' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'
    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    material = Material.first
    material_type = MaterialType.find_by(id: 'book')
    # get :edit, curriculum

    patch :quickupdate,id: material.id, :material => { :id=>material.id, :material_url => 'http://google.com', :material_type_id => material_type.id,:description => 'this is description' + strTime}, format: :js
    assert flash[:error]
    puts flash[:error]
  end

  # Description: update empty material type
  # @author: CuongCT
  # Create Date: 18/12/2014
  # Modify Date:
  test 'update empty material type ' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'
    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    material = Material.first
    material_type = MaterialType.find_by(id: 'book')
    # get :edit, curriculum

    patch :quickupdate,id: material.id, :material => { :id=>material.id, :material_name => 'update'+strTime,:material_url => 'http://google.com', :description => 'this is description' + strTime}, format: :js
    assert flash[:error]
    puts flash[:error]
  end
  #===============================================       FAILED              ==========================================================
  #===============================================       MAXLENGTH           ==========================================================
  # Description: update material name maxlength
  # @author: CuongCT
  # Create Date: 18/12/2014
  # Modify Date:
  test 'update material name maxlength' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'
    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    material = Material.first
    material_type = MaterialType.find_by(id: 'book')
    # get :edit, curriculum
    marterial_name = ""
    for i in 0..101
      marterial_name = marterial_name + 'i'
    end
    patch :quickupdate,id: material.id, :material => {:id=>material.id, :material_name => marterial_name,:material_url => 'http://google.com', :material_type_id => material_type.id,:description => 'this is description' + strTime}, format: :js
    assert flash[:error]
    puts flash[:error]
  end

  # Description: update material url maxlength
  # @author: CuongCT
  # Create Date: 18/12/2014
  # Modify Date:
  test 'update material url maxlength' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'
    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    material = Material.first
    material_type = MaterialType.find_by(id: 'book')
    # get :edit, curriculum
    marterial_url = "http://google.com/"
    for i in 0..501
      marterial_url = marterial_url + 'i'
    end
    patch :quickupdate,id: material.id, :material => { :id=>material.id,:material_name => 'marterial_name',:material_url => marterial_url, :material_type_id => material_type.id,:description => 'this is description' + strTime}, format: :js
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
    material = Material.first
    material_type = MaterialType.find_by(id: 'book')
    # get :edit, curriculum
    marterial_url = "http://google.com/"
    for i in 0..10001
      marterial_url = marterial_url + 'i'
    end
    patch :quickupdate, id: material.id, :material => { :id=>material.id,:material_name => 'marterial_name',:material_url => '', :material_type_id => material_type.id,:description => marterial_url}, format: :js
    assert flash[:error]
    puts flash[:error]
  end

  #===============================================       FAILED              ==========================================================
  #===============================================       WRONG FORMAT        ==========================================================
  # Description: update material url format
  # @author: CuongCT
  # Create Date: 18/12/2014
  # Modify Date:
  test 'update material url format' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'
    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    material = Material.first
    material_type = MaterialType.find_by(id: 'book')
    # get :edit, curriculum
    marterial_url = "hts://goosm/"

    patch :quickupdate,id: material.id, :material => {:id=>material.id, :material_name => 'marterial_name',:material_url => marterial_url, :material_type_id => material_type.id,:description => 'marterial_url'}, format: :js
    assert flash[:error]
    puts flash[:error]
  end
end
