class LinesController < ApplicationController
  before_action :set_line, only:[:show, :edit, :update, :destroy]
  before_action :require_login, only: [:new, :create, :get_in_line]

  def index
    # SEARCH FEATURE AND GEOLOCATION CONFIG
    if params.has_key?(:search_value) and params[:search_value] != ""
      @results = policy_scope(Line).line_search(params[:search_value])
      @hash = Gmaps4rails.build_markers(@results) do |line, marker|
        marker.lat line.latitude
        marker.lng line.longitude
      end
    else
      # @results = Line.all
      @results = policy_scope(Line)
      @hash = Gmaps4rails.build_markers(@results) do |line, marker|
        if line.latitude
          marker.lat line.latitude
          marker.lng line.longitude
        else
          marker.lat '41.4089506'
          marker.lng '2.1523962'
          # CHANGE!
        end
      end
    end
  end

  def show
    # !!!!! THE CODE BELOW MUST BE REFACTORED TO SEPARATE METHODS (MAYBE HELPERS AND MODEL METHODS)

    # CREATE AN ARRAY WITH APPOINTMENTS LISTED ACCORDING TO CREATED_AT
    @current_line = @line.appointments.order("created_at ASC")

    # CREATE AN ARRAY WITH ADMINISTRATORS LISTED ACCORDING TO CREATED_AT
    @admins = @line.administrators.order("created_at ASC")

    # CHECK IF CURRENT USER IS HOST
    current_user.id == @line.user_id ? @user_is_host = true : @user_is_host = false

    # CHECK IF CURRENT USER IS ADMIN
    @admins.each do |admin|
      if admin.user == current_user
        @user_is_admin = true
      end
    end

    # CHECK IF CURRENT USER IS IN LINE
    @user = current_user
    @user_in_line = false
    @app = nil

    # REFACTOR IF POSSIBLE (e.g. just writing app.user == @user will return a boolean)
    @current_line.each do |app|
      if app.user == @user
        @user_in_line = true
        @app = app
      end
    end

    # USER SEARCH FUNCTION
    if params.has_key?(:search_value) and params[:search_value] != ""
      @results = User.user_search(params[:search_value])
    else
      @users = User.all
    end

    # GEOLOCATION CONFIG
    @alert_message = "You are viewing #{@line.title}"
    @line_coordinates = [@line]
    @hash = Gmaps4rails.build_markers(@line_coordinates) do |line, marker|
      if line.latitude
        marker.lat line.latitude
        marker.lng line.longitude
      else
        marker.lat '41.4089506'
        marker.lng '2.1523962'
        # CHANGE!
      end
    end
  end

  def new
    @line = Line.new
    authorize @line
  end

  def create

    start_t = params[:line][:start_time]
    end_t = params[:line][:end_time]

    if start_t != '' && end_t != ''
      start_p =  DateTime.strptime(start_t, '%m/%d/%Y %H:%M %p')
      end_p = DateTime.strptime(end_t, '%m/%d/%Y %H:%M %p')
    end

    @line = Line.new(line_params)
    authorize @line
    @line.start_time = start_p
    @line.end_time = end_p

    if @line.save
      redirect_to lines_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    start_t = params[:line][:start_time]
    end_t = params[:line][:end_time]

    if start_t != '' && end_t != ''
      start_p =  DateTime.strptime(start_t, '%m/%d/%Y %H:%M %p')
      end_p = DateTime.strptime(end_t, '%m/%d/%Y %H:%M %p')
    end

    @line.update(line_params)
    @line.start_time = start_p
    @line.end_time = end_p
    @line.save!

    redirect_to line_path(@line)
  end

  def destroy
    @line.destroy
    redirect_to lines_path
  end

  def get_in_line
    @line = Line.find(params[:line_id])
    authorize @line
    @user = current_user
    Appointment.create(user_id: @user.id, line_id: @line.id)
    redirect_to line_path(@line)
    flash[:notice] = "You have successfully secured a place in this line."
  end

  def make_admin
    @line = Line.find(params[:line_id])
    @user = User.find(params[:user_id])
    authorize @line
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
    authorize @line
  end

  def line_params
    params.require(:line).permit(:title, :organization_name, :location, :start_time, :end_time, :avg_service_time, :user_id, :photo, :photo_cache)
  end

  def require_login
    if !current_user
       flash[:alert] = "You need to sign in to continue!"
      redirect_to new_user_session_path
    end
  end

end
