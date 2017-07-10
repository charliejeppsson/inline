class AdministratorsController < ApplicationController

  def destroy
    @administrator = Administrator.find(params[:id])
    @user = @administrator.user
    @line = Line.find(@administrator.line_id)
    authorize @line
    @administrator.destroy
    redirect_to line_path(@line)
    flash[:notice] = "#{@user.first_name} #{@user.last_name} is no longer an admin of this line."
  end
end
