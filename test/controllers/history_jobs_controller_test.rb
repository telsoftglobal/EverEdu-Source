require 'test_helper'

class HistoryJobsControllerTest < ActionController::TestCase
  setup do
    @history_job = history_jobs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:history_jobs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create history_job" do
    assert_difference('HistoryJob.count') do
      post :create, history_job: { company_name: @history_job.company_name, current: @history_job.current, description: @history_job.description, end_time: @history_job.end_time, location: @history_job.location, start_time: @history_job.start_time, title: @history_job.title }
    end

    assert_redirected_to history_job_path(assigns(:history_job))
  end

  test "should show history_job" do
    get :show, id: @history_job
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @history_job
    assert_response :success
  end

  test "should update history_job" do
    patch :update, id: @history_job, history_job: { company_name: @history_job.company_name, current: @history_job.current, description: @history_job.description, end_time: @history_job.end_time, location: @history_job.location, start_time: @history_job.start_time, title: @history_job.title }
    assert_redirected_to history_job_path(assigns(:history_job))
  end

  test "should destroy history_job" do
    assert_difference('HistoryJob.count', -1) do
      delete :destroy, id: @history_job
    end

    assert_redirected_to history_jobs_path
  end
end
