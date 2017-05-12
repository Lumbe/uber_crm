class CommentsController < ApplicationController
  before_action :load_commentable

  def create
    @comment = @commentable.comments.new(comment_params)

    if @comment.save
      redirect_to @commentable, notice: 'Комментарий добавлен'
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
