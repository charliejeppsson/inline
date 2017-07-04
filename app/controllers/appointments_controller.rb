class AppointmentsController < ApplicationController
  def index
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @line = Line.find(@appointment.line_id)
    @appointment.destroy
    redirect_to line_path(@line)
    flash[:notice] = "You have now dropped out of this line."
  end

  # def dashboard
  #   @my_appointments = current_user.lines.order(start_time: :asc).select{|line| line.start_time > (Time.now - (2*7*24*60*60)) }
  # end

end
