class CommentsController < ApplicationController
  before_action :set_ticket
  before_action only: [:edit, :update] do
    set_comment
    same_user(@comment.creator)
  end

  def create
    @comment = @ticket.comments.build(comment_params)
    @comment.creator = current_user

    if @comment.save
      update_ticket_status
      comment_successfully(:posted)
    else
      render 'tickets/show'
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      update_ticket_status
      comment_successfully(:updated)
    else
      render :edit
    end    
  end

  private

  def comment_params
    params.require(:comment).permit(:body)   
  end

  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def update_ticket_status
    updated_status = params.require(:comment).permit(:ticket)['ticket']
    @ticket.update(status: updated_status) unless updated_status.blank?
  end

  def comment_successfully(action)
    redirect_to ticket_path(@ticket), notice: "Your comment was successfully #{action}."    
  end
end