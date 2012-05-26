module ApplicationHelper

 def user_grid_class(time)
    is_late(time) ? "late" : "normal"
 end

 def format_to_time(time)
	time = time.to_f
    Time.at(time).strftime("%I:%M %p")
 end
 
 def format_to_date(time)
    time = time.to_f
    Time.at(time).strftime("%d-%m-%Y")
 end

 def is_late(time)
    time = time.to_f
    Time.at(time).hour>= User::DEFAULT_TIME && Time.at(time).min>= 1 
 end
end
