class CommentsController < ApplicationController
  
  def index
    @comments = Comment.all
  end
  
  def show
    
  end
  
  def new
    @comment = Comment.new
  end
  
  def create
    
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
end
