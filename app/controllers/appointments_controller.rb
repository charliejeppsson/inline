class AppointmentsController < ApplicationController

  def destroy
    @appointment = Appointment.find(params[:id])
    authorize @appointment
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

end
