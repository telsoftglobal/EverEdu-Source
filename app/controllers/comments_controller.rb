class CommentsController < ApplicationController
  layout 'default'

  before_action :authenticate

  def index
  end


  # Description: This method processes create new comment
  # @param
  # @return
  # @throws Exception
  # @author HuyenDT
  # Create Date: 2014/11/29
  # Modify Date: 2014/12/01
  def create
    begin
      object_type = params[:object_type].camelize
      object_id = BSON::ObjectId.from_string(params[:object_id])

      #get object
      @object = object_type.singularize.constantize.find(object_id)

      #build new comment
      @comment = Comment.new
      @comment.object_id = object_id
      @comment.object_type = object_type

      if params[:comment]
        # @comment.content = params[:comment].strip
        @comment.content = params[:comment].strip
      end

      #author of comment
      user_id = session[:user_id]
      author = User.find(user_id)
      if !author.nil?
        @comment.author = author
        @comment.author_info = {_id: author.id, user_name: author.user_name}
      end

      if @comment.save
        #get total comments
        @total_comments = Comment.get_total_comments(@object.id, @object.object_type)

        # create notify to mentor
        if @object.get_author.id != @comment.author.id
          begin
            notify_new_comment(@object, @comment.id, Notification::COMMENT_TYPE, @object.id, @object.object_type)
          rescue Exception => e
            logger.error("notification save error: #{e.message}")
          end
        end

        # response
        respond_to do |format|
          format.js
          format.html
        end
      else
        respond_to do |format|
          if @comment.errors
           flash.now[:error] = @comment.errors.full_messages.to_sentence(:last_word_connector => ', ');
          else
            flash.now[:error] = t('comments.msg_comment_fail')
          end
          format.js { render action: 'failed_save' }
          format.html
        end
      end
    rescue Exception => e
      logger.error("Comment save error: #{e.message}")
      respond_to do |format|
        flash.now[:error] = t('comments.msg_comment_fail')
        format.js { render action: 'failed_save' }
        format.html
      end
    end
  end

  # Description: This method processes create reply
  # @param
  # @return
  # @throws Exception
  # @author HuyenDT
  # Create Date: 2014/12/04
  # Modify Date: 2014/12/04
  def reply
    begin
      object_type = params[:object_type].camelize
      object_id = BSON::ObjectId.from_string(params[:object_id])
      parent_id = BSON::ObjectId.from_string(params[:parent_id])

      #get object
      @object = object_type.singularize.constantize.find(object_id)

      #get comment parent
      @comment = Comment.find_by(id: parent_id)
      if @comment.nil?
        throw Exception
      end

      #build new comment
      @reply = Comment.new
      @reply.object_id = object_id
      @reply.object_type = object_type
      @reply.parent = @comment

      if params[:comment]
        @reply.content = params[:comment].strip
      end

      #author of comment
      user_id = session[:user_id]
      author = User.find(user_id)
      if !author.nil?
        @reply.author = author
        @reply.author_info = {_id: author.id, user_name: author.user_name}
      end

      if @reply.save
        #get total comments
        @total_comments = Comment.get_total_comments(@object.id, @object.object_type)
        @total_replies = @comment.replies.count

        # create notify to mentor
        # if @object.get_author.id != @comment.author.id
        #   begin
        #     notify_new_comment(@object, @reply.id, Notification::COMMENT_TYPE, @object.id, @object.object_type)
        #   rescue Exception => e
        #     logger.error("notification save error: #{e.message}")
        #   end
        # end

        # response
        respond_to do |format|
          format.js
          format.html
        end
      else
        respond_to do |format|
          if @reply.errors
            flash.now[:error] = @reply.errors.full_messages.to_sentence(:last_word_connector => ', ');
          else
            flash.now[:error] = t('comments.msg_reply_fail')
          end
          format.js { render action: 'reply_fail' }
          format.html
        end
      end
    rescue Exception => e
      logger.error("Comment save error: #{e.message}")
      respond_to do |format|
        flash.now[:error] = t('comments.msg_reply_fail')
        format.js { render action: 'reply_fail' }
        #format.html
      end
    end
  end

  # Description: This method processes get more comments
  # @param
  # @return
  # @throws Exception
  # @author HuyenDT
  # Create Date: 2014/11/29
  # Modify Date: 2014/12/01
  def get_more_comments
    begin
      object_type = params[:object_type].camelize
      object_id = params[:object_id]
      last_comment_id = params[:last_comment_id]

      if object_type && object_id && !object_type.blank? && !object_id.blank?
        object_id = BSON::ObjectId.from_string(object_id)

        #get object
        @object = object_type.singularize.constantize.find(object_id)
        @total_only_comments = @object.get_total_comments_not_reply

        if last_comment_id
          last_comment_id = BSON::ObjectId.from_string(last_comment_id)
        end

        @comments = Comment.get_more_comments(object_id, object_type, last_comment_id)

        respond_to do |format|
          format.js
          format.html
        end
      else
        respond_to do |format|
          flash.now[:error] = t('comments.msg_get_more_comments_fail')
          format.js { render action: 'get_more_comments_fail' }
        end
      end
    rescue Exception => e
      logger.error("get_more_comments error: #{e.message}")
      respond_to do |format|
        flash.now[:error] = t('comments.msg_get_more_comments_fail')
        format.js { render action: 'get_more_comments_fail' }
      end
    end
  end

  def new
  end

  private
    # Description: This method processes notify to mentor when have new comment
    # @param
    # @return
    # @throws Exception
    # @author HuyenDT
    # Create Date: 2014/11/29
    # Modify Date: 2014/12/01
    def notify_new_comment(object, activity_id, activity_type, object_id, object_type)
      notification = Notification.new
      notification.activity_id = activity_id
      notification.activity_type = activity_type
      notification.object_id = object_id
      notification.object_type = object_type

      #find recipient
      notification.recipient = object.get_author

      # if @comment.object_type.eql?Comment::CURRICULUM_TYPE
      #   notification.content = "#{@comment.author.user_name} #{I18n.t('comments.msg_notify_new_comment')} #{@object.curriculum_name}"
      # elsif @comment.object_type.eql?Comment::MATERIAL_TYPE
      #   notification.content = "#{@comment.author.user_name} #{I18n.t('comments.msg_notify_new_comment')} #{@object.material_name}"
      # elsif @comment.object_type.eql?Comment::ACTION_TYPE
      #   notification.content = "#{@comment.author.user_name} #{I18n.t('comments.msg_notify_new_comment')} #{@object.action_name}"
      # else
      #   notification.content = "#{@comment.author.user_name} #{I18n.t('comments.msg_notify_new_comment')}"
      # end
      notification.save
    end
end
