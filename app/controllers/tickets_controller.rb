class TicketsController < ApplicationController
  before_action :find_ticket, only: [:show, :edit, :update, :destroy]
  
  def index
    @tickets = Ticket.all
  end

  def show
  end

  def new
    @projects = Project.all
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)

    if @ticket.save
      flash[:notice] = 'Ticket was successfully created.'
      redirect_to ticket_path(@ticket)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @ticket.update(ticket_params)
      flash[:notice] = 'Ticket was successfully updated.'
      redirect_to ticket_path(@ticket)
    else
      render :edit
    end    
  end

  def destroy
    @ticket.destroy
    flash[:notice] = "Ticket was successfully destroyed."

    redirect_to tickets_path
  end

  private

  def ticket_params
    params.require(:ticket).permit(:name, :body, :status, :project_id, tag_ids: [])
  end

  def find_ticket
    @ticket = Ticket.find(params[:id])
  end
end