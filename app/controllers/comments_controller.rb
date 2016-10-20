class CommentsController < ApplicationController
  before_filter :load_commentable
  
  def index
    @comments = @commentable.comments.order(created_at: :desc)
  end
  
  def show
    
  end
  
  def new
    @comment = @commentable.comments.new
  end
  
  def create
    @comment = @commentable.comments.new(comment_params)
    if @comment.save
      @commentable.update(status: 'proposal', proposal_sent: Time.zone.now) if @commentable.is_a?(Contact) && @comment.comment_type == 'commercial_prop'
      @commentable.update(status: 'finished') if @commentable.is_a?(Contact) && @comment.comment_type == 'phone_call'
      redirect_to @commentable, notice: "Комментарий добавлен"
    else
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
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
