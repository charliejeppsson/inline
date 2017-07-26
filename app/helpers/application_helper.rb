module ApplicationHelper

  # HELPER TO CALCULATE HOW MANY PEOPLE IS IN FRONT OF THE CURRENT USER
  def est_time_left(current_line) # Passing the line instance variable
    # Check if current user is in line
    user_in_line = false
    current_line.appointments.each do |app|
      if app["user_id"] == current_user.id
        user_in_line = true
      end
    end

    current_user_position = nil

    if user_in_line
      current_line.appointments.each_with_index do |appointment, index|
        if appointment["user_id"].to_i == current_user.id
          current_user_position = index
        end
      end
      # If user is not in line we calculate the total line
      people_in_front = current_line.appointments[0..current_user_position-1].count
    else
      # If user is in line we calculate the amount of people in front
      people_in_front = current_line.appointments.count
    end

    # Calculate the est time left in minutes
    admins = current_line.administrators
    minutes_left = people_in_front * current_line.avg_service_time
    # Take into account eventual line administrators
    admins.count > 0 ? minutes_left = minutes_left / (admins.count + 1) : minutes_left

    if minutes_left > 120
      hours_left = 2
    elsif minutes_left <= 135 && minutes_left > 105
      hours_left = 2
    elsif minutes_left <= 105 && minutes_left > 75
      hours_left = 1.5
    elsif minutes_left <= 75 && minutes_left > 45
      hours_left = 1
    else
      hours_left = 0.5
    end

    return hours_left
  end

end
