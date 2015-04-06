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

  def render_latest_curriculums(user)
    curriculums = user.curriculums.order_by(created_at: -1).limit(3)
    curriculum_info = ''
    curriculums.each do |c|
      curriculum_info << link_to(c.curriculum_name, c)
      curriculum_info << ',  '
    end

    if !curriculum_info.blank?
      curriculum_info = curriculum_info.strip
      curriculum_info = curriculum_info[0, curriculum_info.length - 1]

      if user.curriculums.count() > 3
        curriculum_info << ' ...'
      end
    end
    curriculum_info.html_safe
  end

  def render_current_job_info(user)
    job = user.history_jobs.order_by(current:-1,end_time: -1, start_time: -1).first

    current_job = ''
    if !job.nil?
      current_job << job.title << ' - ' << job.company_name
    end

    current_job.html_safe
  end

  def render_company_info(user)
    jobs = user.history_jobs.order_by(current:-1,end_time: -1, start_time: -1).limit(3)

    company_info = ''
    jobs.each do |job|
      company_info << link_to(job.company_name, job.company_url)
      company_info << ', '
    end

    if !company_info.blank?
      company_info = company_info.strip
      company_info = company_info[0, company_info.length - 1]
    end

    company_info.html_safe
  end

  def render_specialty_info(user)
    specialties = user.specialties.order_by(created_at: -1)

    specialty_info = ''
    specialties.each do |s|
      specialty_info << s.specialty
      specialty_info << ', '
    end

    if !specialty_info.blank?
      specialty_info = specialty_info.strip
      specialty_info = specialty_info[0, specialty_info.length - 1]
    end
    specialty_info.html_safe
  end
end
