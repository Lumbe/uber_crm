class CommentsController < ApplicationController
  before_action :load_commentable
  
  def index
    @comments = @commentable.comments.order(created_at: :desc)
  end

  def new
    @comment = @commentable.comments.new
  end
  
  def create
    @comment = @commentable.comments.new(comment_params)
    if @comment.save
      if @commentable.is_a?(Contact) && @comment.comment_type == 'commercial_prop'
        @commentable.update(status: 'proposal', proposal_sent: Time.zone.now)
        @commentable.create_activity :send_proposal, owner: current_user, trackable_department_id: @commentable.department_id
      elsif @commentable.is_a?(Contact) && @comment.comment_type == 'phone_call'
        @commentable.update(status: 'finished')
        @commentable.create_activity :phone_call, owner: current_user, trackable_department_id: @commentable.department_id
      end

      redirect_to @commentable, notice: "Комментарий добавлен"
    else
      render 'new'
    end
  end

  private
  
  def comment_params
    params.require(:comment).permit(:body, :user_id, :comment_type)
  end
  
  # works well if used default url format
  def load_commentable
    resource, id = request.path.split('/')[1,2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end
  
  # works well if used custom url format
  # -----------------------------------
  # def load_commentable
  #   klass = [Lead, Contact, Customer].detect { |c| params["#{c.name.underscore}_id"] }
  #   @commentable = klass.find(params["#{klass.name.underscore}_id"]) 
  # end
  
end
