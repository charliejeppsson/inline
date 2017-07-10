module ApplicationHelper

  # HELPER TO CALCULATE HOW MANY PEOPLE IS IN FRONT OF THE CURRENT USER
  def people_in_front(current_line)
    # CHECK IF CURRENT USER IS IN LINE
    user_in_line = false
    current_line.each do |app|
      if app["user_id"] == current_user.id
        user_in_line = true
      end
    end

    current_user_position = nil

    if user_in_line
      current_line.each_with_index do |appointment, index|
        if appointment["user_id"].to_i == current_user.id
          current_user_position = index
        end
      end
      people_in_front = current_line[0..current_user_position-1].count
    # IF USER SIGNED IN AND NOT IN LINE WE CALCULATE THE TOTAL EST TIME LEFT
    else
      people_in_front = current_line.count
    end

    return people_in_front
  end

end
