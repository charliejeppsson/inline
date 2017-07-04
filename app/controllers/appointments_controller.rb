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
    @user = @appointment.user
    @line = Line.find(@appointment.line_id)
    @appointment.destroy
    redirect_to line_path(@line)
    if current_user == @user
      flash[:notice] = "You have now dropped out of this line."
    else
      flash[:notice] = "#{@user.first_name} #{@user.last_name} has successfully been removed from this line."
    end
  end

  # def dashboard
  #   @my_appointments = current_user.lines.order(start_time: :asc).select{|line| line.start_time > (Time.now - (2*7*24*60*60)) }
  # end

end
