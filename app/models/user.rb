class User < ActiveRecord::Base
  has_many :user_timings, :dependent=>:destroy
  validates :username, :presence=>{:message=>"Please enter username."},
		:format=>{:with => /^[A-Za-z\d_]+$/ ,:message=>"Username should conatin only letters."},
		:uniqueness=>{:message=>"Usename already exist."}

  DEFAULT_TIME = 10
  
  def User.authenticate(username)
	User.find(:first, :conditions=>["username=?",username])
  end
  

  def late_arrival
	start_time = Date.today.beginning_of_month
	end_time = Date.today.end_of_month
	timings = self.user_timings.find(:all, :conditions=>["entry_time>=? AND entry_time<=?",start_time,end_time])
	late = 0
	timings.each do |t|
	  late += t.is_late? ? 1 : 0
	end
 	late
  end

  def avg_arrival_time
	all_time = self.user_timings
	User.avg_time(all_time)
  end

  def self.avg_time(times)
	total_time = 0
	times.each do |time|
	  total_time += time.entry_time.to_f
	end
	Time.at(total_time/times.length).strftime("%I:%M %P") if total_time !=0
  end
end
