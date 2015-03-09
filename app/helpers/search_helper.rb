module SearchHelper
  def get_link_curriculum_detail_page(curriculum)
    # if user is author of curriculum

    # link = link_to t('search_curriculum.lb_read_more'), curriculum
    #
    # if curriculum.mentor.id == current_user.id
    #   link = link_to t('search_curriculum.lb_read_more'), show_curriculum_detail_for_mentor_path(curriculum)
    # else
    #   study_progress = CurriculumStudyProgress.find_by(curriculum_id: curriculum.id, student_id: current_user.id);
    #   if !study_progress.nil?
    #     link = link_to t('search_curriculum.lb_read_more'), show_curriculum_detail_for_student_path(curriculum)
    #   end
    # end
    #
    # link.html_safe
  end

end
