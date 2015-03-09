require 'test_helper'

class CurriculumsControllerTest < ActionController::TestCase

  # Description: view list curriculum: when mentor log in to system
  # @author: HaPT
  # Create Date: 15/11/2014
  # Modify Date:
  test "view all curriculums of mentor" do
    @current_user = User.find_by(_id: BSON::ObjectId.from_string("544f58b54875791e70030000"))
    session[:user_id] = @current_user._id
    get :index, {:page => 1}
    assert_response :success
    assert_not_nil assigns(:curriculums)
  end

  # Description: view list curriculum: mentor seach with only category
  # @author: HaPT
  # Create Date: 15/11/2014
  # Modify Date:
  test "view list curriculum when only option category" do
    @current_user = User.find_by(_id: BSON::ObjectId.from_string("5449dbc748757910f0070000"))
    session[:user_id] = @current_user._id
    get :index, {:category_id => '546484ed4875793289200100', :keyword => 'curriculum 2', :page => 1}
    assert_response :success
    assert_not_nil assigns(:curriculums)
  end

  # Description: view list curriculum: mentor seach with only curriculum_name
  # @author: HaPT
  # Create Date: 15/11/2014
  # Modify Date:
  test "view list curriculum when only enter curriculum_name" do
    @current_user = User.find_by(_id: BSON::ObjectId.from_string("5449dbc748757910f0070000"))
    session[:user_id] = @current_user._id
    get :index, {:keyword => 'curriculum 2', :page => 1}
    assert_response :success
    assert_not_nil assigns(:curriculums)
    # assert_nil @curriculums.nil?
  end

  # Description: view list curriculum: mentor seach with curriculum_name only input special characters
  # @author: HaPT
  # Create Date: 15/11/2014
  # Modify Date:
  test "view list curriculum when only enter curriculum_name with special characters" do
    @current_user = User.find_by(_id: BSON::ObjectId.from_string("5449dbc748757910f0070000"))
    session[:user_id] = @current_user._id
    get :index, {:category_id => '', :keyword => '&*()&^%$#', :page => 1}
    assert_response :success
    assert_nil assigns(:curriculums.nil?)
  end

  # Description: view list curriculum: mentor seach with curriculum_name only input number
  # @author: HaPT
  # Create Date: 15/11/2014
  # Modify Date:
  test "view list curriculum when only enter curriculum_name with number only" do
    @current_user = User.find_by(_id: BSON::ObjectId.from_string("5449dbc748757910f0070000"))
    session[:user_id] = @current_user._id
    get :index, {:keyword => '12345', :page => 1}
    assert_response :success
    assert_nil assigns(:curriculums.nil?)
  end

  # Description: view list curriculum: mentor seach with curriculum_name input alphanumeric characters and special characters
  # @author: HaPT
  # Create Date: 15/11/2014
  # Modify Date:
  test "view list curriculum when only enter curriculum_name with alphanumeric characters and special characters" do
    @current_user = User.find_by(_id: BSON::ObjectId.from_string("5449dbc748757910f0070000"))
    session[:user_id] = @current_user._id
    get :index, {:keyword => 'curriculum 123 #$%@^&*()', :page => 1}
    assert_response :success
    assert_nil assigns(:curriculums.nil?)
  end

  # Description: view list curriculum: mentor seach with curriculum_name input white spaces before, after curriculum name
  # @author: HaPT
  # Create Date: 15/11/2014
  # Modify Date:
  test "view list curriculum with white spaces before, after curriculum_name" do
    @current_user = User.find_by(_id: BSON::ObjectId.from_string("5449dbc748757910f0070000"))
    session[:user_id] = @current_user._id
    get :index, {:keyword => '         curriculum 2                ', :page => 1}
    assert_response :success
    assert_not_nil assigns(:curriculums)
  end

  # Description: view list curriculum: mentor seach with curriculum_name input only white spaces
  # @author: HaPT
  # Create Date: 15/11/2014
  # Modify Date:
  test "view list curriculum with only white spaces" do
    @current_user = User.find_by(_id: BSON::ObjectId.from_string("5449dbc748757910f0070000"))
    session[:user_id] = @current_user._id
    get :index, {:keyword => '                         ', :page => 1}
    assert_response :success
    assert_not_nil assigns(:curriculums)
  end

  # Description: view list curriculum: mentor seach with curriculum_name is value of curriculum exist
  # @author: HaPT
  # Create Date: 15/11/2014
  # Modify Date:
  test "view list curriculum with curriculum_name is value of one curriculum" do
    @current_user = User.find_by(_id: BSON::ObjectId.from_string("5449dbc748757910f0070000"))
    session[:user_id] = @current_user._id
    get :index, {:keyword => 'curriculum 2 TV/Media/Newspaper', :page => 1}
    assert_response :success
    assert_not_nil assigns(:curriculums)
  end

  # Description: view list curriculum: mentor seach with curriculum_name isn't value of curriculum exist
  # @author: HaPT
  # Create Date: 15/11/2014
  # Modify Date:
  test "view list curriculum with curriculum_name isn't value of one curriculum" do
    @current_user = User.find_by(_id: BSON::ObjectId.from_string("5449dbc748757910f0070000"))
    session[:user_id] = @current_user._id
    get :index, {:keyword => 'fhsdfieriidfnsjf fhsdfhsdfeiruei', :page => 1}
    assert_response :success
    assert_nil assigns(:curriculums.nil?)
  end

  # Description: view list curriculum: mentor seach with curriculum_name is first word of curriculum exist
  # @author: HaPT
  # Create Date: 15/11/2014
  # Modify Date:
  test "view list curriculum with curriculum_name is first word of one curriculum" do
    @current_user = User.find_by(_id: BSON::ObjectId.from_string("5449dbc748757910f0070000"))
    session[:user_id] = @current_user._id
    get :index, {:keyword => 'curriculum', :page => 1}
    assert_response :success
    assert_not_nil assigns(:curriculums)
  end

  # Description: view list curriculum: mentor seach with curriculum_name is middle word of curriculum exist
  # @author: HaPT
  # Create Date: 15/11/2014
  # Modify Date:
  test "view list curriculum with curriculum_name is middle word of one curriculum" do
    @current_user = User.find_by(_id: BSON::ObjectId.from_string("5449dbc748757910f0070000"))
    session[:user_id] = @current_user._id
    get :index, {:keyword => 'sales', :page => 1}
    assert_response :success
    assert_not_nil assigns(:curriculums)
  end

  # Description: view list curriculum: mentor seach with curriculum_name is middle word of curriculum exist
  # @author: HaPT
  # Create Date: 15/11/2014
  # Modify Date:
  test "view list curriculum with curriculum_name is uper case" do
    @current_user = User.find_by(_id: BSON::ObjectId.from_string("5449dbc748757910f0070000"))
    session[:user_id] = @current_user._id
    get :index, {:keyword => 'CUrriculuM 2', :page => 1}
    assert_response :success
    assert_not_nil assigns(:curriculums)
  end

  # Description: Check role
  # @author: HaPT
  # Create Date: 15/11/2014
  # Modify Date:
  test "check role" do
    @current_user = User.find_by(_id: BSON::ObjectId.from_string("546ed9494861501af7010000"))
    session[:user_id] = @current_user._id
    get :index
    assert_redirected_to home_error_path
  end
  # Description: view detail of curriculum: when mentor click Read more
  # @author: SonNH
  # Create Date: 18/11/2014
  # Modify Date:
  test "should show curriculum" do
    @current_user = User.find_by(_id: BSON::ObjectId.from_string("544f58b54875791e70030000"))
    session[:user_id] = @current_user._id
    @curriculum=Curriculum.find_by(_id: BSON::ObjectId.from_string("546b1ca74d52531624340000"))
    get :show, id: @curriculum
    assert_response :success
  end

  # Description: student join to learn curriculum successful
  # @author: HuyenDT
  # Create Date: 24/11/2014
  # Modify Date:
  test "join curriculum successful" do
    curriculum_name = 'Test join 1'
    user_name = 'sonnh'
    category_name = 'IT'
    student_name = 'huyendt'

    #delete old data
    curriculum = Curriculum.find_by(curriculum_name: curriculum_name)
    student = User.find_by(user_name: student_name)
    if !curriculum.nil?
      assert Curriculum.delete_all(curriculum_name: curriculum_name)
      assert Material.delete_all(curriculum_id: curriculum.id)
      assert Action.delete_all(curriculum_id: curriculum.id)
      assert CurriculumStudyProgress.delete_all(curriculum_id: curriculum.id, student_id: student.id)
      assert MaterialStudyProgress.delete_all(curriculum_id: curriculum.id, student_id: student.id)
      assert ActionStudyProgress.delete_all(curriculum_id: curriculum.id, student_id: student.id)
    end

    #create data test
    curriculum = Curriculum.new
    curriculum.curriculum_name = curriculum_name
    curriculum.summary = "summary of #{curriculum_name}"
    curriculum.description = "description of #{curriculum_name}"
    curriculum.mentor = User.find_by(user_name: user_name)
    category = Category.find_by(category_name: category_name)
    curriculum.curriculum_categories = [CurriculumCategory.new(category_id: category.id, category_name: category.category_name)]


    material_count = 0
    while material_count < 2 do
      material_count = material_count + 1
      material = Material.new
      material.curriculum = curriculum
      material.material_name = "material #{material_count} of #{name}"
      material.material_type = MaterialType.find_by(show_priority: 1 + Random.rand(3))
      material.material_url = 'http://'
      material.description = "description of #{material.material_name}"
      curriculum.materials << material
    end

    action_count = 0
    while action_count < 2 do
      action_count = action_count + 1
      action = Action.new
      action.curriculum = curriculum
      action.action_name = "action #{action_count} of #{name}"
      action.description = "description of #{action.action_name}"
      curriculum.actions << action
    end

    assert curriculum.save
    curriculum.materials.each do |material|
      assert material.save
    end

    curriculum.actions.each do |action|
      assert action.save
    end


    curriculum = Curriculum.find_by(curriculum_name: curriculum_name)
    student = User.find_by(user_name: student_name)
    session[:user_id] = student.id

    get :join, {id: curriculum.id}

    assert_redirected_to show_curriculum_for_student_path(curriculum)
    assert_equal flash[:notice], I18n.t('join.msg_join_successful')

    curriculum_progress = CurriculumStudyProgress.find_by(curriculum_id: curriculum.id, student_id: student.id)
    assert_not_nil curriculum_progress

    curriculum.materials.each do |material|
      existed = false
      curriculum_progress.material_study_progresses.each do |material_progress|
        if material.id == material_progress.material_id and material_progress.status == ProgressType::TO_DO
          existed = true
          break
        end
      end
      assert existed, 'material not existed'
    end

    curriculum.actions.each do |actions|
      existed = false
      curriculum_progress.action_study_progresses.each do |action_progress|
        if action.id == action_progress.action_id and action_progress.status == ProgressType::TO_DO
          existed = true
          break
        end
      end
      assert existed, 'action not existed'
    end
  end

  # Description: mentor join to learn curriculum successful. Please run test join curriculum successful before
  # @author: HuyenDT
  # Create Date: 24/11/2014
  # Modify Date:
  test "join curriculum which student is author of" do
    curriculum_name = 'Test join 1'
    student_name = 'sonnh'

    curriculum = Curriculum.find_by(curriculum_name: curriculum_name)
    student = User.find_by(user_name: student_name)
    session[:user_id] = student.id

    get :join, {id: curriculum.id}

    assert_redirected_to show_curriculum_for_mentor_path(curriculum)

    curriculum_progress = CurriculumStudyProgress.find_by(curriculum_id: curriculum.id, student_id: student.id)
    assert curriculum_progress.nil?

  end


  # Description: student join to learn curriculum what you have ever joined. Please run test join curriculum successful before
  # @author: HuyenDT
  # Create Date: 24/11/2014
  # Modify Date:
  test "join curriculum what you have ever joined" do
    curriculum_name = 'Test join 1'
    user_name = 'sonnh'
    category_name = 'IT'
    student_name = 'huyendt'


    curriculum = Curriculum.find_by(curriculum_name: curriculum_name)
    student = User.find_by(user_name: student_name)
    session[:user_id] = student.id

    get :join, {id: curriculum.id}

    assert_redirected_to show_curriculum_for_student_path(curriculum)
    assert_equal flash[:notice], I18n.t('join.msg_joined')
  end

  # Description: student join to learn not found curriculum
  # @author: HuyenDT
  # Create Date: 24/11/2014
  # Modify Date:
  test "join curriculum what not found" do
    curriculum_name = 'Test join 1'
    user_name = 'sonnh'
    category_name = 'IT'
    student_name = 'huyendt'


    curriculum = Curriculum.find_by(curriculum_name: curriculum_name)
    student = User.find_by(user_name: student_name)
    session[:user_id] = student.id

    #delete curriculum
    curriculum = Curriculum.find_by(curriculum_name: curriculum_name)
    student = User.find_by(user_name: student_name)
    if !curriculum.nil?
      assert Curriculum.delete_all(curriculum_name: curriculum_name)
      assert Material.delete_all(curriculum_id: curriculum.id)
      assert Action.delete_all(curriculum_id: curriculum.id)
      assert CurriculumStudyProgress.delete_all(curriculum_id: curriculum.id, student_id: student.id)
      assert MaterialStudyProgress.delete_all(curriculum_id: curriculum.id, student_id: student.id)
      assert ActionStudyProgress.delete_all(curriculum_id: curriculum.id, student_id: student.id)
    end

    get :join, {id: curriculum.id}

    assert_redirected_to home_error_path
    assert_equal flash[:error], I18n.t('join.msg_curriculum_not_found')
  end


  #=============================CuongCT TDD Create curriculum==========================================

  # Description: Create Curriculum full info
  # @author: CuongCT
  # Create Date: 26/11/2014
  # Modify Date:
  test 'Create curriculum full info' do

    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    # get :new

    post :create, :curriculum => {:curriculum_name => 'this is curriculum name ', :summary => 'this is summary',:description => 'this is description',:mentor_id=>session[:user_id],
                                  :materials_attributes => {'0' => {:state=>'new', :material_id => '0',:material_name => 'this is material 1 name',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book'},
                                                           '1' => {:state=>'new', :material_name => 'this is material 2 name',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book'},
                                                           '2' => {:state=>'new', :material_name => 'this is material 3 name',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book',:parent_id=> '1'}
                                  },
                                  :actions_attributes => {'0' => {:state=>'new', :action_name => 'action 1', :description => 'this is action description'}
                                  },
                                  :curriculum_categories_attributes => {'0' => {:category_id => '5466c14348757911e8000000',:category_name => 'Administrative/Clerical',
                                                                                :level_ids => {'0'=> '5466c14448757911e8010000','1' => '5466c14448757911e8020000'}
                                                                        },
                                                                        '1' => {:category_id => '5466c14448757911e8510000',:category_name => 'Chemical/Biochemical',
                                                                                :level_ids => {'0'=> '5466c14448757911e8540000','1' => '5466c14448757911e8550000'}
                                                                        }
                                  }
                }
    # assert_response 's'
    assert_redirected_to assigns(:curriculum)
    # puts assigns(:curriculum).id

    curriculum_created = Curriculum.find_by(id: assigns(:curriculum).id)

    puts 'name: ' + curriculum_created.curriculum_name
    puts 'summary: ' + curriculum_created.summary
    puts 'description: ' + curriculum_created.description

    curriculum_created.materials.each do |material|
      puts "--------------------"
      puts material.material_name
      puts material.material_url
      puts material.description
    end

    curriculum_created.actions.each do |action|
      puts "--------------------"
      puts action.action_name
      puts action.description
    end

    curriculum_created.curriculum_categories.each do |categories|
      puts "---------------------"
      puts categories.category_name
      puts "list level"
      categories.levels.each do |level|
        puts level.level_name
      end
    end

  end

  # Description: Create curriculum one material
  # @author: CuongCT
  # Create Date: 26/11/2014
  # Modify Date:
  test 'Create curriculum one material' do

    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    get :new

    post :create, :curriculum => {:curriculum_name => 'this is curriculum name ', :summary => 'this is summary',:description => 'this is description',:mentor_id=>session[:user_id],
                                  :materials_attributes => {'0' => {:state=>'new', :material_id => '0',:material_name => 'this is material 1 name',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book'},
                                  },
                                  :actions_attributes => {'0' => {:state=>'new', :action_name => 'action 1', :description => 'this is action description'}
                                  },
                                  :curriculum_categories_attributes => {'0' => {:category_id => '5466c14348757911e8000000',:category_name => 'Administrative/Clerical',
                                                                                :level_ids => {'0'=> '5466c14448757911e8010000','1' => '5466c14448757911e8020000'}
                                  },
                                                                        '1' => {:category_id => '5466c14448757911e8510000',:category_name => 'Chemical/Biochemical',
                                                                                :level_ids => {'0'=> '5466c14448757911e8540000','1' => '5466c14448757911e8550000'}
                                                                        }
                                  }
                }
    # assert_response 's'
    assert_redirected_to assigns(:curriculum)
    curriculum_created = Curriculum.find_by(id: assigns(:curriculum).id)

    puts 'name: ' + curriculum_created.curriculum_name
    puts 'summary: ' + curriculum_created.summary
    puts 'description: ' + curriculum_created.description

    curriculum_created.materials.each do |material|
      puts "--------------------"
      puts material.material_name
      puts material.material_url
      puts material.description
    end

    curriculum_created.actions.each do |action|
      puts "--------------------"
      puts action.action_name
      puts action.description
    end

    curriculum_created.curriculum_categories.each do |categories|
      puts "---------------------"
      puts categories.category_name
      puts "list level"
      categories.levels.each do |level|
        puts level.level_name
      end
    end
  end

  # Description: Create curriculum one action
  # @author: CuongCT
  # Create Date: 26/11/2014
  # Modify Date:
  test 'Create curriculum one action' do

    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    get :new

    post :create, :curriculum => {:curriculum_name => 'this is curriculum name ', :summary => 'this is summary',:description => 'this is description',:mentor_id=>session[:user_id],
                                  :materials_attributes => {'0' => {:state=>'new', :material_id => '0',:material_name => 'this is material 1 name',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book'},
                                  },
                                  :actions_attributes => {'0' => {:state=>'new', :action_name => 'action 1', :description => 'this is action description'}
                                  },
                                  :curriculum_categories_attributes => {'0' => {:category_id => '5466c14348757911e8000000',:category_name => 'Administrative/Clerical',
                                                                                :level_ids => {'0'=> '5466c14448757911e8010000','1' => '5466c14448757911e8020000'}
                                  },
                                                                        '1' => {:category_id => '5466c14448757911e8510000',:category_name => 'Chemical/Biochemical',
                                                                                :level_ids => {'0'=> '5466c14448757911e8540000','1' => '5466c14448757911e8550000'}
                                                                        }
                                  }
                }
    # assert_response 's'
    assert_redirected_to assigns(:curriculum)
    curriculum_created = Curriculum.find_by(id: assigns(:curriculum).id)

    puts 'name: ' + curriculum_created.curriculum_name
    puts 'summary: ' + curriculum_created.summary
    puts 'description: ' + curriculum_created.description

    curriculum_created.materials.each do |material|
      puts "--------------------"
      puts material.material_name
      puts material.material_url
      puts material.description
    end

    curriculum_created.actions.each do |action|
      puts "--------------------"
      puts action.action_name
      puts action.description
    end

    curriculum_created.curriculum_categories.each do |categories|
      puts "---------------------"
      puts categories.category_name
      puts "list level"
      categories.levels.each do |level|
        puts level.level_name
      end
    end
  end

  # Description: Create curriculum one category
  # @author: CuongCT
  # Create Date: 26/11/2014
  # Modify Date:
  test 'Create curriculum one category' do

    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    get :new

    post :create, :curriculum => {:curriculum_name => 'this is curriculum name ', :summary => 'this is summary',:description => 'this is description',:mentor_id=>session[:user_id],
                                  :materials_attributes => {'0' => {:state=>'new', :material_id => '0',:material_name => 'this is material 1 name',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book'},
                                                           '1' => {:state=>'new', :material_name => 'this is material 2 name',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book'},
                                                           '2' => {:state=>'new', :material_name => 'this is material 2 name',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book',:parent_id=> '1'}
                                  },
                                  :actions_attributes => {'0' => {:state=>'new', :action_name => 'action 1', :description => 'this is action description'}
                                  },
                                  :curriculum_categories_attributes => {'0' => {:category_id => '5466c14348757911e8000000',:category_name => 'Administrative/Clerical'}
                                  }
                }
    # assert_response 's'
    assert_redirected_to assigns(:curriculum)
    curriculum_created = Curriculum.find_by(id: assigns(:curriculum).id)

    puts 'name: ' + curriculum_created.curriculum_name
    puts 'summary: ' + curriculum_created.summary
    puts 'description: ' + curriculum_created.description

    curriculum_created.materials.each do |material|
      puts "--------------------"
      puts material.material_name
      puts material.material_url
      puts material.description
    end

    curriculum_created.actions.each do |action|
      puts "--------------------"
      puts action.action_name
      puts action.description
    end

    curriculum_created.curriculum_categories.each do |categories|
      puts "---------------------"
      puts categories.category_name
      puts "list level"
      categories.levels.each do |level|
        puts level.level_name
      end
    end
  end

  #Create failed


  # Description: Create curriculum empty curriculum name
  # @author: CuongCT
  # Create Date: 26/11/2014
  # Modify Date:
  test 'Create curriculum empty curriculum name' do

    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    get :new

    post :create, :curriculum => {:curriculum_name => '', :summary => 'this is summary',:description => 'this is description',:mentor_id=>session[:user_id],
                                  :materials_attributes => {'0' => {:state=>'new', :material_id => '0',:material_name => 'this is material 1 name',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book'},
                                                           '1' => {:state=>'new', :material_name => 'this is material 2 name',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book'},
                                                           '2' => {:state=>'new', :material_name => 'this is material 2 name',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book',:parent_id=> '1'}
                                  },
                                  :actions_attributes => {'0' => {:state=>'new', :action_name => 'action 1', :description => 'this is action description'}
                                  },
                                  :curriculum_categories_attributes => {'0' => {:category_id => '5466c14348757911e8000000',:category_name => 'Administrative/Clerical',
                                                                                :level_ids => {'0'=> '5466c14448757911e8010000','1' => '5466c14448757911e8020000'}
                                  },
                                                                        '1' => {:category_id => '5466c14448757911e8510000',:category_name => 'Chemical/Biochemical',
                                                                                :level_ids => {'0'=> '5466c14448757911e8540000','1' => '5466c14448757911e8550000'}
                                                                        }
                                  }
                }
    # assert_response 's'
    # assert_redirected_to assigns(:curriculum)
    # assert_equal flash[:error], I18n.t('attributes.action_name')
    assert flash[:error]
    flash[:error].each do |message|
      puts message
    end
  end

  # Description: Create curriculum empty curriculum summary
  # @author: CuongCT
  # Create Date: 26/11/2014
  # Modify Date:
  test 'Create curriculum empty curriculum summary' do

    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    # get :new

    post :create, :curriculum => {:curriculum_name => 'This is curriculum name', :summary => '',:description => 'this is description',:mentor_id=>session[:user_id],
                                  :materials_attributes => {'0' => {:state=>'new', :material_id => '0',:material_name => 'this is material 1 name',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book'},
                                                           '1' => {:state=>'new', :material_name => 'this is material 2 name',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book'},
                                                           '2' => {:state=>'new', :material_name => 'this is material 2 name',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book',:parent_id=> '1'}
                                  },
                                  :actions_attributes => {'0' => {:state=>'new', :action_name => 'action 1', :description => 'this is action description'}
                                  },
                                  :curriculum_categories_attributes => {'0' => {:category_id => '5466c14348757911e8000000',:category_name => 'Administrative/Clerical',
                                                                                :level_ids => {'0'=> '5466c14448757911e8010000','1' => '5466c14448757911e8020000'}
                                  },
                                                                        '1' => {:category_id => '5466c14448757911e8510000',:category_name => 'Chemical/Biochemical',
                                                                                :level_ids => {'0'=> '5466c14448757911e8540000','1' => '5466c14448757911e8550000'}
                                                                        }
                                  }
                }
    # assert_response 's'
    # assert_redirected_to assigns(:curriculum)
    # assert_equal flash[:error], I18n.t('attributes.action_name')
    assert flash[:error]
    flash[:error].each do |message|
      puts message
    end
  end

  test 'Create curriculum empty material name' do
    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    get :new

    post :create, :curriculum => {:curriculum_name => 'This is curriculum name', :summary => 'This is summary',:description => 'this is description',:mentor_id=>session[:user_id],
                                  :materials_attributes => {'0' => {:state=>'new', :material_id => '0',:material_name => '',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book'}
                                  },
                                  :actions_attributes => {'0' => {:state=>'new', :action_name => 'action 1', :description => 'this is action description'}
                                  },
                                  :curriculum_categories_attributes => {'0' => {:category_id => '5466c14348757911e8000000',:category_name => 'Administrative/Clerical',
                                                                                :level_ids => {'0'=> '5466c14448757911e8010000','1' => '5466c14448757911e8020000'}
                                  },
                                                                        '1' => {:category_id => '5466c14448757911e8510000',:category_name => 'Chemical/Biochemical',
                                                                                :level_ids => {'0'=> '5466c14448757911e8540000','1' => '5466c14448757911e8550000'}
                                                                        }
                                  }
                }
    # assert_response 's'
    # assert_redirected_to assigns(:curriculum)
    # assert_equal flash[:error], I18n.t('attributes.action_name')
    # assert_redirected_to home_error_path
    assert flash[:error]
    if flash[:error].instance_of?Array
      flash[:error].each do |message|
        puts message
      end
    else
      puts flash[:error]
    end
  end

  # Description: Create curriculum empty material
  # @author: CuongCT
  # Create Date: 26/11/2014
  # Modify Date:
  test 'Create curriculum empty material' do
    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    get :new

    post :create, :curriculum => {:curriculum_name => 'This is curriculum name', :summary => 'This is summary',:description => 'this is description',:mentor_id=>session[:user_id],

                                  :actions_attributes => {'0' => {:state=>'new', :action_name => 'action 1', :description => 'this is action description'}
                                  },
                                  :curriculum_categories_attributes => {'0' => {:category_id => '5466c14348757911e8000000',:category_name => 'Administrative/Clerical',
                                                                                :level_ids => {'0'=> '5466c14448757911e8010000','1' => '5466c14448757911e8020000'}
                                  },
                                                                        '1' => {:category_id => '5466c14448757911e8510000',:category_name => 'Chemical/Biochemical',
                                                                                :level_ids => {'0'=> '5466c14448757911e8540000','1' => '5466c14448757911e8550000'}
                                                                        }
                                  }
                }
    # assert_response 's'
    # assert_redirected_to assigns(:curriculum)
    # assert_equal flash[:error], I18n.t('attributes.action_name')
    assert_redirected_to home_error_path
    # assert flash[:error]
    if flash[:error].instance_of?Array
      flash[:error].each do |message|
        puts message
      end
    else
      puts flash[:error]
    end
  end


  # Description: Create curriculum empty categories
  # @author: CuongCT
  # Create Date: 26/11/2014
  # Modify Date:
  test 'Create curriculum empty categories' do

    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    # get :new

    post :create, :curriculum => {:curriculum_name => 'This is curriculum name', :summary => '',:description => 'this is description',:mentor_id=>session[:user_id],
                                  :materials_attributes => {'0' => {:state=>'new', :material_id => '0',:material_name => 'this is material 1 name',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book'},
                                                           '1' => {:state=>'new', :material_name => 'this is material 2 name',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book'},
                                                           '2' => {:state=>'new', :material_name => 'this is material 2 name',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book',:parent_id=> '1'}
                                  },
                                  :actions_attributes => {'0' => {:state=>'new', :action_name => 'action 1', :description => 'this is action description'}
                                  }
                }
    # assert_response 's'
    # assert_redirected_to assigns(:curriculum)
    # assert_equal flash[:error], I18n.t('attributes.action_name')
    assert flash[:error]
    flash[:error].each do |message|
      puts message
    end
  end

  # Description: Create curriculum empty categories
  # @author: CuongCT
  # Create Date: 26/11/2014
  # Modify Date:
  test 'Create curriculum empty action name' do
    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    get :new

    post :create, :curriculum => {:curriculum_name => 'This is curriculum name', :summary => 'This is summary',:description => 'this is description',:mentor_id=>session[:user_id],
                                  :materials_attributes => {'0' => {:state=>'new', :material_id => '0',:material_name => 'This is material name',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book'}
                                  },
                                  :actions_attributes => {'0' => {:state=>'new', :action_name => '', :description => 'this is action description'}
                                  },
                                  :curriculum_categories_attributes => {'0' => {:category_id => '5466c14348757911e8000000',:category_name => 'Administrative/Clerical',
                                                                                :level_ids => {'0'=> '5466c14448757911e8010000','1' => '5466c14448757911e8020000'}
                                  },
                                                                        '1' => {:category_id => '5466c14448757911e8510000',:category_name => 'Chemical/Biochemical',
                                                                                :level_ids => {'0'=> '5466c14448757911e8540000','1' => '5466c14448757911e8550000'}
                                                                        }
                                  }
                }
    # assert_response 's'
    # assert_redirected_to assigns(:curriculum)
    # assert_equal flash[:error], I18n.t('attributes.action_name')
    # assert_redirected_to home_error_path
    assert flash[:error]
    if flash[:error].instance_of?Array
      flash[:error].each do |message|
        puts message
      end
    else
      puts flash[:error]
    end
  end

  #Max length
  # Description: Create curriculum maxlength curriculum name
  # @author: CuongCT
  # Create Date: 26/11/2014
  # Modify Date:
  test 'Create curriculum maxlength curriculum name' do

    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    # get :new

    post :create, :curriculum => {:curriculum_name => '1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|', :summary => 'this is summary',:description => 'this is description',:mentor_id=>session[:user_id],
                                  :materials_attributes => {'0' => {:state=>'new', :material_id => '0',:material_name => 'this is material 1 name',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book'},
                                                           '1' => {:state=>'new', :material_name => 'this is material 2 name',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book'},
                                                           '2' => {:state=>'new', :material_name => 'this is material 2 name',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book',:parent_id=> '1'}
                                  },
                                  :actions_attributes => {'0' => {:state=>'new', :action_name => 'action 1', :description => 'this is action description'}
                                  },
                                  :curriculum_categories_attributes => {'0' => {:category_id => '5466c14348757911e8000000',:category_name => 'Administrative/Clerical',
                                                                                :level_ids => {'0'=> '5466c14448757911e8010000','1' => '5466c14448757911e8020000'}
                                  },
                                                                        '1' => {:category_id => '5466c14448757911e8510000',:category_name => 'Chemical/Biochemical',
                                                                                :level_ids => {'0'=> '5466c14448757911e8540000','1' => '5466c14448757911e8550000'}
                                                                        }
                                  }
                }
    # assert_response 's'
    # assert_redirected_to assigns(:curriculum)
    # assert_equal flash[:error], I18n.t('attributes.action_name')
    assert flash[:error]
    flash[:error].each do |message|
      puts message
    end
  end

  # Description: Create curriculum maxlength curriculum summary
  # @author: CuongCT
  # Create Date: 26/11/2014
  # Modify Date:
  test 'Create curriculum maxlength curriculum summary' do

    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    # get :new

    post :create, :curriculum => {:curriculum_name => 'This is material name', :summary => '1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|',:description => 'this is description',:mentor_id=>session[:user_id],
                                  :materials_attributes => {'0' => {:state=>'new', :material_id => '0',:material_name => 'this is material 1 name',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book'},
                                                           '1' => {:state=>'new', :material_name => 'this is material 2 name',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book'},
                                                           '2' => {:state=>'new', :material_name => 'this is material 2 name',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book',:parent_id=> '1'}
                                  },
                                  :actions_attributes => {'0' => {:state=>'new', :action_name => 'action 1', :description => 'this is action description'}
                                  },
                                  :curriculum_categories_attributes => {'0' => {:category_id => '5466c14348757911e8000000',:category_name => 'Administrative/Clerical',
                                                                                :level_ids => {'0'=> '5466c14448757911e8010000','1' => '5466c14448757911e8020000'}
                                  },
                                                                        '1' => {:category_id => '5466c14448757911e8510000',:category_name => 'Chemical/Biochemical',
                                                                                :level_ids => {'0'=> '5466c14448757911e8540000','1' => '5466c14448757911e8550000'}
                                                                        }
                                  }
                }
    # assert_response 's'
    # assert_redirected_to assigns(:curriculum)
    # assert_equal flash[:error], I18n.t('attributes.action_name')
    assert flash[:error]
    flash[:error].each do |message|
      puts message
    end
  end

  # Description: Create curriculum maxlength material name
  # @author: CuongCT
  # Create Date: 26/11/2014
  # Modify Date:
  test 'Create curriculum maxlength material name' do

    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    # get :new

    post :create, :curriculum => {:curriculum_name => 'This is material name', :summary => 'This is material summary',:description => 'this is description',:mentor_id=>session[:user_id],
                                  :materials_attributes => {'0' => {:state=>'new', :material_id => '0',:material_name => '1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book'},
                                                           '1' => {:state=>'new', :material_name => 'this is material 2 name',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book'},
                                                           '2' => {:state=>'new', :material_name => 'this is material 2 name',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book',:parent_id=> '1'}
                                  },
                                  :actions_attributes => {'0' => {:state=>'new', :action_name => 'action 1', :description => 'this is action description'}
                                  },
                                  :curriculum_categories_attributes => {'0' => {:category_id => '5466c14348757911e8000000',:category_name => 'Administrative/Clerical',
                                                                                :level_ids => {'0'=> '5466c14448757911e8010000','1' => '5466c14448757911e8020000'}
                                  },
                                                                        '1' => {:category_id => '5466c14448757911e8510000',:category_name => 'Chemical/Biochemical',
                                                                                :level_ids => {'0'=> '5466c14448757911e8540000','1' => '5466c14448757911e8550000'}
                                                                        }
                                  }
                }
    # assert_response 's'
    # assert_redirected_to assigns(:curriculum)
    # assert_equal flash[:error], I18n.t('attributes.action_name')
    assert flash[:error]
    flash[:error].each do |message|
      puts message
    end
  end

  # Description: Create curriculum maxlength action name
  # @author: CuongCT
  # Create Date: 26/11/2014
  # Modify Date:
  test 'Create curriculum maxlength action name' do

    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    # get :new

    post :create, :curriculum => {:curriculum_name => 'This is material name', :summary => 'This is material summary',:description => 'this is description',:mentor_id=>session[:user_id],
                                  :materials_attributes => {'0' => {:state=>'new', :material_id => '0',:material_name => 'This is material name 1',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book'},
                                                           '1' => {:state=>'new', :material_name => 'this is material 2 name',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book'},
                                                           '2' => {:state=>'new', :material_name => 'this is material 2 name',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book',:parent_id=> '1'}
                                  },
                                  :actions_attributes => {'0' => {:action_name => '1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|', :description => 'this is action description'}
                                  },
                                  :curriculum_categories_attributes => {'0' => {:category_id => '5466c14348757911e8000000',:category_name => 'Administrative/Clerical',
                                                                                :level_ids => {'0'=> '5466c14448757911e8010000','1' => '5466c14448757911e8020000'}
                                  },
                                                                        '1' => {:category_id => '5466c14448757911e8510000',:category_name => 'Chemical/Biochemical',
                                                                                :level_ids => {'0'=> '5466c14448757911e8540000','1' => '5466c14448757911e8550000'}
                                                                        }
                                  }
                }
    # assert_response 's'
    # assert_redirected_to assigns(:curriculum)
    # assert_equal flash[:error], I18n.t('attributes.action_name')
    assert flash[:error]
    flash[:error].each do |message|
      puts message
    end
  end

  #Url format
  # Description: Create curriculum material url format
  # @author: CuongCT
  # Create Date: 26/11/2014
  # Modify Date:
  test 'Create curriculum material url format' do

    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    # get :new

    post :create, :curriculum => {:curriculum_name => 'This is material name', :summary => 'This is material summary',:description => 'this is description',:mentor_id=>session[:user_id],
                                  :materials_attributes => {'0' => {:state=>'new',:material_id => '0',:material_name => 'This is material name 1',:material_url => 'htelsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book'},
                                                           '1' => {:state=>'new',:material_name => 'this is material 2 name',:material_url => 'htoft.com.vn',:description=> 'this is description',:material_type_id=> 'book'},
                                                           '2' => {:state=>'new',:material_name => 'this is material 2 name',:material_url => 'htelsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book',:parent_id=> '1'}
                                  },
                                  :actions_attributes => {'0' => {:state=>'new',:action_name => 'this is action name', :description => 'this is action description'}
                                  },
                                  :curriculum_categories_attributes => {'0' => {:category_id => '5466c14348757911e8000000',:category_name => 'Administrative/Clerical',
                                                                                :level_ids => {'0'=> '5466c14448757911e8010000','1' => '5466c14448757911e8020000'}
                                  },
                                                                        '1' => {:category_id => '5466c14448757911e8510000',:category_name => 'Chemical/Biochemical',
                                                                                :level_ids => {'0'=> '5466c14448757911e8540000','1' => '5466c14448757911e8550000'}
                                                                        }
                                  }
                }
    # assert_response 's'
    # assert_redirected_to assigns(:curriculum)
    # assert_equal flash[:error], I18n.t('attributes.action_name')
    assert flash[:error]
    flash[:error].each do |message|
      puts message
    end
  end

  # Description: Create curriculum maxlength material name
  # @author: CuongCT
  # Create Date: 26/11/2014
  # Modify Date:
  test 'Create curriculum maxlength material description' do

    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    # get :new

    post :create, :curriculum => {:curriculum_name => 'This is material name', :summary => 'This is material summary',:description => 'this is description',:mentor_id=>session[:user_id],
                                  :materials_attributes => {'0' => {:state=>'new', :material_id => '0',:material_name => 'materila name',:material_url => 'http://telsoft.com.vn',:description=> '1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|',:material_type_id=> 'book'},
                                                            '1' => {:state=>'new', :material_name => 'this is material 2 name',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book'},
                                                            '2' => {:state=>'new', :material_name => 'this is material 2 name',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book',:parent_id=> '1'}
                                  },
                                  :actions_attributes => {'0' => {:state=>'new', :action_name => 'action 1', :description => 'this is action description'}
                                  },
                                  :curriculum_categories_attributes => {'0' => {:category_id => '5466c14348757911e8000000',:category_name => 'Administrative/Clerical',
                                                                                :level_ids => {'0'=> '5466c14448757911e8010000','1' => '5466c14448757911e8020000'}
                                  },
                                                                        '1' => {:category_id => '5466c14448757911e8510000',:category_name => 'Chemical/Biochemical',
                                                                                :level_ids => {'0'=> '5466c14448757911e8540000','1' => '5466c14448757911e8550000'}
                                                                        }
                                  }
                }
    # assert_response 's'
    # assert_redirected_to assigns(:curriculum)
    # assert_equal flash[:error], I18n.t('attributes.action_name')
    assert flash[:error]
    flash[:error].each do |message|
      puts message
    end
  end

  # Description: Create curriculum maxlength action name
  # @author: CuongCT
  # Create Date: 26/11/2014
  # Modify Date:
  test 'Create curriculum maxlength action desciption' do

    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    # get :new

    post :create, :curriculum => {:curriculum_name => 'This is material name', :summary => 'This is material summary',:description => 'this is description',:mentor_id=>session[:user_id],
                                  :materials_attributes => {'0' => {:state=>'new', :material_id => '0',:material_name => 'This is material name 1',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book'},
                                                            '1' => {:state=>'new', :material_name => 'this is material 2 name',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book'},
                                                            '2' => {:state=>'new', :material_name => 'this is material 2 name',:material_url => 'http://telsoft.com.vn',:description=> 'this is description',:material_type_id=> 'book',:parent_id=> '1'}
                                  },
                                  :actions_attributes => {'0' => {:action_name => 'action name', :description => '1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|'}
                                  },
                                  :curriculum_categories_attributes => {'0' => {:category_id => '5466c14348757911e8000000',:category_name => 'Administrative/Clerical',
                                                                                :level_ids => {'0'=> '5466c14448757911e8010000','1' => '5466c14448757911e8020000'}
                                  },
                                                                        '1' => {:category_id => '5466c14448757911e8510000',:category_name => 'Chemical/Biochemical',
                                                                                :level_ids => {'0'=> '5466c14448757911e8540000','1' => '5466c14448757911e8550000'}
                                                                        }
                                  }
                }
    # assert_response 's'
    # assert_redirected_to assigns(:curriculum)
    # assert_equal flash[:error], I18n.t('attributes.action_name')
    assert flash[:error]
    flash[:error].each do |message|
      puts message
    end
  end



  #=============================CuongCT TDD UPDATE CURRICULUM ==========================================
  # Description: Update Curriculum full info
  # @author: CuongCT
  # Create Date: 1/12/2014
  # Modify Date:
  test 'Update curriculum full info' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    curriculum = Curriculum.first
    materialupdate = curriculum.materials[0]
    # get :edit, curriculum

    patch :update,id: curriculum.id, :curriculum => {:id=>'5466c14348757911e8000000',:curriculum_name => 'this is curriculum name ' + strTime, :summary => 'this is summary' + strTime,:description => 'this is description' + strTime,:mentor_id=>session[:user_id],
                                  :materials_attributes => {'0' => {:state=>'new',:material_id => '0',:material_name => 'this is material 1 name' + strTime,:material_url => 'http://telsoft.com.vn',:description=> 'this is description' + strTime,:material_type_id=> 'book'},
                                                            '1' => {:state=>'update',:material_id => materialupdate.id,:material_name => 'materialupdate.material_name' + strTime,:description=> 'this is description' + strTime,:material_type_id=> 'book'}
                                  },
                                  :actions_attributes => {'0' => {:state=>'new',:action_name => 'action 1', :description => 'this is action description'}
                                  },
                                  :curriculum_categories_attributes => {'0' => {:category_id => '5466c14348757911e8000000',:category_name => 'Administrative/Clerical',
                                                                                :level_ids => {'0'=> '5466c14448757911e8010000','1' => '5466c14448757911e8020000'}
                                  },
                                                                        '1' => {:category_id => '5466c14448757911e8510000',:category_name => 'Chemical/Biochemical',
                                                                                :level_ids => {'0'=> '5466c14448757911e8540000','1' => '5466c14448757911e8550000'}
                                                                        }
                                  }
                }
    # assert_response 's'
    assert_redirected_to assigns(:curriculum)
    # puts assigns(:curriculum).id

    curriculum_updated = Curriculum.find_by(id: curriculum.id)

    puts 'name: ' + curriculum_updated.curriculum_name
    puts 'summary: ' + curriculum_updated.summary
    puts 'description: ' + curriculum_updated.description

    curriculum_updated.materials.each do |material|
      puts "--------------------"
      puts material.material_name
      puts material.material_url
      puts material.description
    end

    curriculum_updated.actions.each do |action|
      puts "--------------------"
      puts action.action_name
      puts action.description
    end

    curriculum_updated.curriculum_categories.each do |categories|
      puts "---------------------"
      puts categories.category_name
      puts "list level"
      categories.levels.each do |level|
        puts level.level_name
      end
    end

  end

  # Description: Update Curriculum name
  # @author: CuongCT
  # Create Date: 1/12/2014
  # Modify Date:
  test 'Update curriculum info' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    curriculum = Curriculum.first
    # get :edit, curriculum

    patch :update,id: curriculum.id, :curriculum => {:id=>curriculum.id,:curriculum_name => 'this is curriculum name ' + strTime, :summary => 'this is summary' + strTime,:description => 'this is description' + strTime

                 }
    # assert_response 's'
    assert_redirected_to assigns(:curriculum)
    # puts assigns(:curriculum).id

    curriculum_updated = Curriculum.find_by(id: curriculum.id)

    puts 'name: ' + curriculum_updated.curriculum_name
    puts 'summary: ' + curriculum_updated.summary
    puts 'description: ' + curriculum_updated.description

    curriculum_updated.materials.each do |material|
      puts "--------------------"
      puts material.material_name
      puts material.material_url
      puts material.description
    end

    curriculum_updated.actions.each do |action|
      puts "--------------------"
      puts action.action_name
      puts action.description
    end

    curriculum_updated.curriculum_categories.each do |categories|
      puts "---------------------"
      puts categories.category_name
      puts "list level"
      categories.levels.each do |level|
        puts level.level_name
      end
    end

  end

  # Description: Update Curriculum summary
  # @author: CuongCT
  # Create Date: 1/12/2014
  # Modify Date:
  test ' curriculum material info' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    curriculum = Curriculum.first
    materialupdate = curriculum.materials[0]
    # get :edit, curriculum

    patch :update,id: curriculum.id, :curriculum => {:id=>curriculum.id,:curriculum_name => 'this is curriculum name ' + strTime, :summary => 'this is summary' + strTime,:description => 'this is description' + strTime,:mentor_id=>session[:user_id],
                                                     :materials_attributes => {'0' => {:state=>'new',:material_id => '0',:material_name => 'this is material 1 name' + strTime,:material_url => 'http://telsoft.com.vn',:description=> 'this is description' + strTime,:material_type_id=> 'book'},
                                                                               '1' => {:state=>'update',:material_id => materialupdate.id,:material_name => 'materialupdate.material_name' + strTime,:material_url => materialupdate.material_url,:description=> 'this is description' + strTime,:material_type_id=> 'book'}
                                                     }

                 }
    # assert_response 's'
    assert_redirected_to assigns(:curriculum)
    # puts assigns(:curriculum).id

    curriculum_updated = Curriculum.find_by(id: curriculum.id)

    puts 'name: ' + curriculum_updated.curriculum_name
    puts 'summary: ' + curriculum_updated.summary
    puts 'description: ' + curriculum_updated.description

    curriculum_updated.materials.each do |material|
      puts "--------------------"
      puts material.material_name
      puts material.material_url
      puts material.description
    end

    curriculum_updated.actions.each do |action|
      puts "--------------------"
      puts action.action_name
      puts action.description
    end

    curriculum_updated.curriculum_categories.each do |categories|
      puts "---------------------"
      puts categories.category_name
      puts "list level"
      categories.levels.each do |level|
        puts level.level_name
      end
    end

  end

  # Description: Update Curriculum summary
  # @author: CuongCT
  # Create Date: 1/12/2014
  # Modify Date:
  test ' curriculum action info' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    curriculum = Curriculum.first
    materialupdate = curriculum.materials[0]
    # get :edit, curriculum

    patch :update,id: curriculum.id, :curriculum => {:id=>curriculum.id,:curriculum_name => 'this is curriculum name ' + strTime, :summary => 'this is summary' + strTime,:description => 'this is description' + strTime,:mentor_id=>session[:user_id],
                                                     :actions_attributes => {'0' => {:state=>'new',:action_name => 'action 1' + strTime, :description => 'this is action description' + strTime}
                                                     }

                 }
    # assert_response 's'
    assert_redirected_to assigns(:curriculum)
    # puts assigns(:curriculum).id

    curriculum_updated = Curriculum.find_by(id: curriculum.id)

    puts 'name: ' + curriculum_updated.curriculum_name
    puts 'summary: ' + curriculum_updated.summary
    puts 'description: ' + curriculum_updated.description

    curriculum_updated.materials.each do |material|
      puts "--------------------"
      puts material.material_name
      puts material.material_url
      puts material.description
    end

    curriculum_updated.actions.each do |action|
      puts "--------------------"
      puts action.action_name
      puts action.description
    end

    curriculum_updated.curriculum_categories.each do |categories|
      puts "---------------------"
      puts categories.category_name
      puts "list level"
      categories.levels.each do |level|
        puts level.level_name
      end
    end

  end


  #=============================CuongCT TDD UPDATE CURRICULUM FAILED ==========================================
  #=============================FIELD EMPTY                          ==========================================

  # Description: Update Curriculum name empty
  # @author: CuongCT
  # Create Date: 1/12/2014
  # Modify Date:
  test 'Update curriculum empty curriculum name' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    curriculum = Curriculum.first
    # get :edit, curriculum

    patch :update,id: curriculum.id, :curriculum => {:id=>curriculum.id,:curriculum_name => '', :summary => 'this is summary' + strTime,:description => 'this is description' + strTime

                 }
    assert flash[:error]
    if flash[:error].instance_of?Array
      flash[:error].each do |message|
        puts message
      end
    else
      puts flash[:error]
    end

  end

  # Description: Update Curriculum summary
  # @author: CuongCT
  # Create Date: 1/12/2014
  # Modify Date:
  test 'Update curriculum empty summary' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    curriculum = Curriculum.first

    patch :update,id: curriculum.id, :curriculum => {:id=>curriculum.id,:curriculum_name => 'this is curriculum name ' + strTime, :summary => '' ,:description => 'this is description' + strTime,:mentor_id=>session[:user_id]


                 }
    assert flash[:error]
    if flash[:error].instance_of?Array
      flash[:error].each do |message|
        puts message
      end
    else
      puts flash[:error]
    end

  end



  # Description: Update Curriculum material
  # @author: CuongCT
  # Create Date: 1/12/2014
  # Modify Date:
  test 'Update curriculum empty action name' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    curriculum = Curriculum.first
    materialupdate = curriculum.materials[0]
    # get :edit, curriculum

    patch :update,id: curriculum.id, :curriculum => {:id=>curriculum.id,:curriculum_name => 'this is curriculum name ' + strTime, :summary => 'this is summary' + strTime,:description => 'this is description' + strTime,:mentor_id=>session[:user_id],
                                                     :actions_attributes => {'0' => {:state=>'new',:action_name => '', :description => 'this is action description' + strTime}
                                                     }
                 }
    assert flash[:error]
    if flash[:error].instance_of?Array
      flash[:error].each do |message|
        puts message
      end
    else
      puts flash[:error]
    end
  end

  # Description: Update Curriculum action
  # @author: CuongCT
  # Create Date: 1/12/2014
  # Modify Date:
  test 'Update curriculum empty material name' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    curriculum = Curriculum.first
    materialupdate = curriculum.materials[0]
    # get :edit, curriculum

    patch :update,id: curriculum.id, :curriculum => {:id=>curriculum.id,:curriculum_name => 'this is curriculum name ' + strTime, :summary => 'this is summary' + strTime,:description => 'this is description' + strTime,:mentor_id=>session[:user_id],
                                                     :materials_attributes => {'0' => {:state=>'new',:material_id => '0',:material_name => '',:material_url => 'http://telsoft.com.vn',:description=> 'this is description' + strTime,:material_type_id=> 'book'},
                                                                               '1' => {:state=>'update',:material_id => materialupdate.id,:material_name => '',:material_url => materialupdate.material_url,:description=> 'this is description' + strTime,:material_type_id=> 'book'}
                                                     }
                 }
    assert flash[:error]
    if flash[:error].instance_of?Array
      flash[:error].each do |message|
        puts message
      end
    else
      puts flash[:error]
    end
  end

  #=============================MAXLENGTH                        ==========================================

  # Description: Update Curriculum name empty
  # @author: CuongCT
  # Create Date: 1/12/2014
  # Modify Date:
  test 'Update curriculum maxlength curriculum name' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    curriculum = Curriculum.first
    # get :edit, curriculum

    patch :update,id: curriculum.id, :curriculum => {:id=>curriculum.id,:curriculum_name => '1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|', :summary => 'this is summary' + strTime,:description => 'this is description' + strTime

                 }
    assert flash[:error]
    if flash[:error].instance_of?Array
      flash[:error].each do |message|
        puts message
      end
    else
      puts flash[:error]
    end

  end
  # Description: Update Curriculum name empty
  # @author: CuongCT
  # Create Date: 1/12/2014
  # Modify Date:
  test 'Update curriculum maxlength description' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    curriculum = Curriculum.first
    # get :edit, curriculum

    patch :update,id: curriculum.id, :curriculum => {:id=>curriculum.id,:curriculum_name => 'curriculum name', :summary => 'this is summary' + strTime,:description => 'this is descriptionthis is action description1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|this is action description1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|' + strTime

                 }
    assert flash[:error]
    if flash[:error].instance_of?Array
      flash[:error].each do |message|
        puts message
      end
    else
      puts flash[:error]
    end

  end

  # Description: Update Curriculum summary
  # @author: CuongCT
  # Create Date: 1/12/2014
  # Modify Date:
  test 'Update curriculum maxlength summary' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    curriculum = Curriculum.first

    patch :update,id: curriculum.id, :curriculum => {:id=>curriculum.id,:curriculum_name => 'this is curriculum name ' + strTime, :summary => '1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|' ,:description => 'this is description' + strTime,:mentor_id=>session[:user_id]
                 }
    assert flash[:error]
    if flash[:error].instance_of?Array
      flash[:error].each do |message|
        puts message
      end
    else
      puts flash[:error]
    end
  end

  # Description: Update Curriculum action
  # @author: CuongCT
  # Create Date: 1/12/2014
  # Modify Date:
  test 'Update curriculum maxlength material name' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    curriculum = Curriculum.first
    materialupdate = curriculum.materials[0]
    # get :edit, curriculum

    patch :update,id: curriculum.id, :curriculum => {:id=>curriculum.id,:curriculum_name => 'this is curriculum name ' + strTime, :summary => 'this is summary' + strTime,:description => 'this is description' + strTime,:mentor_id=>session[:user_id],
                                                     :materials_attributes => {'0' => {:state=>'new',:material_id => '0',:material_name => '1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|',:material_url => 'http://telsoft.com.vn',:description=> 'this is description' + strTime,:material_type_id=> 'book'},
                                                                               '1' => {:state=>'update',:material_id => materialupdate.id,:material_name => '1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|',:material_url => materialupdate.material_url,:description=> 'this is description' + strTime,:material_type_id=> 'book'}
                                                     }
                 }
    assert flash[:error]
    if flash[:error].instance_of?Array
      flash[:error].each do |message|
        puts message
      end
    else
      puts flash[:error]
    end
  end

  # Description: Update Curriculum action
  # @author: CuongCT
  # Create Date: 1/12/2014
  # Modify Date:
  test 'Update curriculum maxlength material description' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    curriculum = Curriculum.first
    materialupdate = curriculum.materials[0]
    # get :edit, curriculum

    patch :update,id: curriculum.id, :curriculum => {:id=>curriculum.id,:curriculum_name => 'this is curriculum name ' + strTime, :summary => 'this is summary' + strTime,:description => 'this is description' + strTime,:mentor_id=>session[:user_id],
                                                     :materials_attributes => {'0' => {:state=>'new',:material_id => '0',:material_name => 'material name',:material_url => 'http://telsoft.com.vn',:description=> 'this is description' + strTime,:material_type_id=> 'book'},
                                                                               '1' => {:state=>'update',:material_id => materialupdate.id,:material_name => 'material name',:material_url => materialupdate.material_url,:description=> 'this is description1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|' + strTime,:material_type_id=> 'book'}
                                                     }
                 }
    assert flash[:error]
    if flash[:error].instance_of?Array
      flash[:error].each do |message|
        puts message
      end
    else
      puts flash[:error]
    end
  end




  # Description: Update Curriculum action
  # @author: CuongCT
  # Create Date: 1/12/2014
  # Modify Date:
  test 'Update curriculum maxlength action name' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    curriculum = Curriculum.first
    materialupdate = curriculum.materials[0]
    # get :edit, curriculum

    patch :update,id: curriculum.id, :curriculum => {:id=>curriculum.id,:curriculum_name => 'this is curriculum name ' + strTime, :summary => 'this is summary' + strTime,:description => 'this is description' + strTime,:mentor_id=>session[:user_id],
                                                     :actions_attributes => {'0' => {:state=>'new',:action_name => '1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|', :description => 'this is action description' + strTime}
                                                     }
                 }
    assert flash[:error]
    if flash[:error].instance_of?Array
      flash[:error].each do |message|
        puts message
      end
    else
      puts flash[:error]
    end
  end

  # Description: Update Curriculum action
  # @author: CuongCT
  # Create Date: 1/12/2014
  # Modify Date:
  test 'Update curriculum maxlength action description' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    curriculum = Curriculum.first
    materialupdate = curriculum.materials[0]
    # get :edit, curriculum

    patch :update,id: curriculum.id, :curriculum => {:id=>curriculum.id,:curriculum_name => 'this is curriculum name ' + strTime, :summary => 'this is summary' + strTime,:description => 'this is description' + strTime,:mentor_id=>session[:user_id],
                                                     :actions_attributes => {'0' => {:state=>'new',:action_name => 'action name', :description => 'this is action description1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|this is action description1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|' + strTime}
                                                     }
                 }
    assert flash[:error]
    if flash[:error].instance_of?Array
      flash[:error].each do |message|
        puts message
      end
    else
      puts flash[:error]
    end
  end

  #=============================URL FORMAT                        ==========================================
  # Description: Update Curriculum action
  # @author: CuongCT
  # Create Date: 1/12/2014
  # Modify Date:
  test 'Update curriculum url material format' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    curriculum = Curriculum.first
    materialupdate = curriculum.materials[0]
    # get :edit, curriculum

    patch :update,id: curriculum.id, :curriculum => {:id=>curriculum.id,:curriculum_name => 'this is curriculum name ' + strTime, :summary => 'this is summary' + strTime,:description => 'this is description' + strTime,:mentor_id=>session[:user_id],
                                                     :materials_attributes => {'0' => {:state=>'new',:material_id => '0',:material_name => 'material name',:material_url => 'hcsoft.com.vn',:description=> 'this is description' + strTime,:url => 'dsdsd',:material_type_id=> 'book'},
                                                                               '1' => {:state=>'update',:material_id => materialupdate.id,:material_name => 'material name',:material_url => materialupdate.material_url,:description=> 'this is description' + strTime,:material_type_id=> 'book'}
                                                     }
                 }
    assert flash[:error]
    if flash[:error].instance_of?Array
      flash[:error].each do |message|
        puts message
      end
    else
      puts flash[:error]
    end
  end
  #===============================================       QUICK UPDATE        ==========================================================
  #===============================================       SUCESSFUl           ==========================================================
  # Description: Update Curriculum name
  # @author: CuongCT
  # Create Date: 18/12/2014
  # Modify Date:
  test 'Update quick curriculum info' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    curriculum = Curriculum.first
    # get :edit, curriculum

    patch :quickupdate, :curriculum => {id: curriculum.id, :curriculum_name => 'this is curriculum name ' + strTime, :summary => 'this is summary' + strTime,:description => 'this is description' + strTime},  format: :js
    assert_not flash[:error]
  end
  #===============================================       FAILED              ==========================================================
  #===============================================       EMPTY               ==========================================================
  # Description: Update quick failed empty curriculum name
  # @author: CuongCT
  # Create Date: 18/12/2014
  # Modify Date:
  test 'Update quick failed empty curriculum name' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    curriculum = Curriculum.first
    # get :edit, curriculum

    patch :quickupdate, :curriculum => { id: curriculum.id, :curriculum_name => '', :summary => 'this is summary' + strTime,:description => 'this is description' + strTime}, format: :js
    assert flash[:error]
    puts flash[:error]
  end

  # Description: Update quick failed empty curriculum summary
  # @author: CuongCT
  # Create Date: 18/12/2014
  # Modify Date:
  test 'Update quick failed empty curriculum summary' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    curriculum = Curriculum.first
    # get :edit, curriculum

    patch :quickupdate,:curriculum => { id: curriculum.id, :curriculum_name => 'this is curriculum name ' + strTime, :summary => '',:description => 'this is description' + strTime}, format: :js
    assert flash[:error]
    puts flash[:error]
  end
  #===============================================       MAXLENGTH           ==========================================================
  # Description: Update quick failed maxlength curriculum name
  # @author: CuongCT
  # Create Date: 18/12/2014
  # Modify Date:
  test 'Update quick failed maxlength curriculum name' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    curriculum = Curriculum.first
    # get :edit, curriculum
    curriculum_name = ''
    for i in 0..101
      curriculum_name = curriculum_name+'1'
    end

    patch :quickupdate,:curriculum => { id: curriculum.id, :curriculum_name => curriculum_name, :summary => 'this is summary' + strTime,:description => 'this is description' + strTime}, format: :js
    assert flash[:error]
    puts flash[:error]
  end

  # Description: Update quick failed maxlength curriculum summary
  # @author: CuongCT
  # Create Date: 18/12/2014
  # Modify Date:
  test 'Update quick failed maxlength curriculum summary' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    curriculum = Curriculum.first
    # get :edit, curriculum
    curriculum_summary = ''
    for i in 0..201
      curriculum_summary = curriculum_summary+'1'
    end
    patch :quickupdate, :curriculum => { id: curriculum.id, :curriculum_name => 'this is curriculum name ' + strTime, :summary => curriculum_summary,:description => 'this is description' + strTime}, format: :js
    assert flash[:error]
    puts flash[:error]
  end

  # Description: Update quick failed maxlength curriculum description
  # @author: CuongCT
  # Create Date: 18/12/2014
  # Modify Date:
  test 'Update quick failed maxlength curriculum description' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    curriculum = Curriculum.first
    # get :edit, curriculum
    description = ''
    for i in 0..10001
      description = description+'1'
    end
    patch :quickupdate,:curriculum => { id: curriculum.id, :curriculum_name => 'this is curriculum name ' + strTime, :summary => 'material_summary',:description => description}, format: :js
    assert flash[:error]
    puts flash[:error]
  end
  #===============================================       QUICK UPDATE CATEGORIES ======================================================
  #===============================================       SUCESSFUl               ======================================================
  # Description: Update quick curriculum categories
  # @author: CuongCT
  # Create Date: 18/12/2014
  # Modify Date:
  test 'Update quick curriculum categories' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    curriculum = Curriculum.first
    # get :edit, curriculum
    patch :quickupdatecategories, :curriculum => {:id=>curriculum.id,
                                                     :curriculum_categories_attributes => {'0' => {:category_id => '5466c14348757911e8000000',:category_name => 'Administrative/Clerical',
                                                                                                   :level_ids => {'0'=> '5466c14448757911e8010000','1' => '5466c14448757911e8020000'}
                                                     },
                                                                                           '1' => {:category_id => '5466c14448757911e8510000',:category_name => 'Chemical/Biochemical',
                                                                                                   :level_ids => {'0'=> '5466c14448757911e8540000','1' => '5466c14448757911e8550000'}
                                                                                           }
                                                     }
                 }, format: :js
    assert_not flash[:error]
  end
  #===============================================       FAILED                  ======================================================
  # Description: Update failed quick curriculum categories
  # @author: CuongCT
  # Create Date: 18/12/2014
  # Modify Date:
  test 'Update failed quick curriculum categories' do
    strTime = " update at: "+Time.now.to_s
    mentor_name = 'cuongct'

    mentor = User.find_by(user_name: mentor_name)
    session[:user_id] = mentor.id
    curriculum = Curriculum.first
    # get :edit, curriculum
    patch :quickupdatecategories, :curriculum => {:id=>curriculum.id,
                                }, format: :js
    assert flash[:error]
    puts flash[:error]
  end

end
