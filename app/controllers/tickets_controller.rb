class TicketsController < ApplicationController
  before_action :require_user, except: [:index, :show]
  before_action :find_ticket, only: [:show, :edit, :update, :destroy]

  def index
    @tickets = if params[:project].present?
                  Project.find(params[:project]).tickets
                else
                  Ticket.all
                end

    @tickets = @tickets.where(status: params[:status]) if params[:status].present?
    @tickets = @tickets.joins(:tags).where("tags.id": params[:tag]) if params[:tag].present?
  end

  def show
    @comment = Comment.new
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params.merge(creator: current_user))

    if @ticket.save 
      ticket_successfully(:created)
    else 
      render :new
    end
  end

  def edit
  end

  def update
    if @ticket.update(ticket_params)
      ticket_successfully(:updated)
    else
      render :edit
    end
  end

  def destroy
    @ticket.destroy
    ticket_successfully(:destroyed, tickets_path)
  end

  private

  def ticket_params
    params.require(:ticket).permit(:name, :body, :status, :project_id, :assignee_id, tag_ids: [])
  end

  def find_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_successfully(action, path=ticket_path(@ticket))
    redirect_to path, notice: "Ticket was successfully #{action}."
  end
end