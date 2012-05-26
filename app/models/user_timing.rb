class UserTiming < ActiveRecord::Base
  belongs_to :user
  validates :user_id , :presence=>true
  validates :entry_time, :presence=>true
  def self.avg_time_of_arrival
	start = Date.today.beginning_of_month
	end_time = Date.today.end_of_month
	all_time = UserTiming.find(:all, :conditions=>["entry_time>=? AND entry_time<=?",start,end_time])
	User.avg_time(all_time)
  end

  def is_late?
   time = self.entry_time.to_f
    Time.at(time).hour>= User::DEFAULT_TIME && Time.at(time).min>= 1 
  end
end
