class LinesController < ApplicationController
  before_action :set_line, only:[:show, :edit, :update, :destroy]
  before_action :require_login, only: [:new, :create, :get_in_line]

  def index
    if params.has_key?(:search_value) and params[:search_value] != ""
      @results = Line.line_search(params[:search_value])
    else
      @lines = Line.all
    end
  end

  def show
    # CREATE AN ARRAY WITH APPOINTMENTS LISTED ACCORDING TO CREATED_AT
    @current_line = @line.appointments.order("created_at ASC")

    # CREATE AN ARRAY WITH ADMINISTRATORS LISTED ACCORDING TO CREATED_AT
    @admins = @line.administrators.order("created_at ASC")

    # CHECK IF CURRENT USER IS HOST
    current_user.id == @line.user_id ? @user_is_host = true : @user_is_host = false

    # CHECK IF CURRENT USER IS ADMIN
    @admins.each do |admin|
      admin.user == current_user ? @user_is_admin = true : @user_is_admin = false
    end

    # CHECK IF CURRENT USER IS IN LINE
    @user = current_user
    @user_in_line = false
    @appointment = nil

    @current_line.each do |app|
      app.user == @user ? @user_in_line = true && @app = app : @user_in_line = false
    end

    # USER SEARCH FUNCTION
    if params.has_key?(:search_value) and params[:search_value] != ""
      @results = User.user_search(params[:search_value])
    else
      @users = User.all
    end
  end

  def new
    @line = Line.new
  end

  def create

    # start_t = params[:line][:start_time]
    # end_t = params[:line][:end_time]

    # if start_t != "" && end_t != ""
    #   start_p =  DateTime.strptime(start_t, "%m/%d/%Y %H:%M %p")
    #   end_p = DateTime.strptime(end_t, "%m/%d/%Y %H:%M %p")
    # end

    @line = Line.new(line_params)
    # @line.start_time = start_p
    # @line.end_time = end_p

    if @line.save
      redirect_to lines_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @line.update(line_params)
    @line.save
    redirect_to line_path(@line)
  end

  def destroy
    @line.destroy
    redirect_to lines_path
  end

  def get_in_line
    @line = Line.find(params[:line_id])
    @user = current_user
    Appointment.create(user_id: @user.id, line_id: @line.id)
    redirect_to line_path(@line)
    flash[:notice] = "You have successfully secured a place in this line."
  end

  def make_admin
    @line = Line.find(params[:line_id])
    @user = User.find(params[:user_id])
    Administrator.create(user_id: @user.id, line_id: @line.id)
    redirect_to line_path(@line)
    flash[:notice] = "#{@user.first_name} #{@user.last_name} has successfully been appointed an admin of this line."
  end

  # def user_in_line # CHECKS IF USER IS IN LINE, RETURNS BOOLEAN AND APPOINTMENT (IF ANY)
  #   @line = Line.find(params[:line_id])
  #   @user = current_user
  #   array = @line.appointments.order("created_at ASC")
  #   @user_in_line = false
  #   @appointment = nil

  #   array.each do |app|
  #     app.user == @user ? user_in_line = true && @appointment = app : @user_in_line = false
  #   end

  #   return [@user_in_line, @appointment] # RETURNS APPOINTMENT TO DESTROY IT WHEN CLICKING DROP-OUT-OF-LINE BUTTON
  # end

  private

  def set_line
    @line = Line.find(params[:id])
  end

  def line_params
    params.require(:line).permit(:title, :organization_name, :location, :start_time, :end_time, :avg_service_time, :user_id, :photo)
  end

  def require_login
    if !current_user
       flash[:alert] = "You need to sign in to continue!"
      redirect_to new_user_session_path
    end
  end

end
