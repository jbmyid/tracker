class TrackerController < ApplicationController
	def home
	  @user = User.new
    	  @sign_user = User.new
          @all_timings = UserTiming.all
	end

   	def create_user
	  @user = User.new(params[:user])
	  @sign_user = User.new
	  @all_timings = UserTiming.all
	  if @user.save
		flash[:message] = "User created successfuly."
		redirect_to :action=>:home
	  else
		render :action=>:home
	  end
	end

   	def sign_in
	  @user = User.authenticate(params[:user][:username])
	  if @user.nil? 
  	    flash[:message] = "User does not exist."
	  else
 	
	    @timining = UserTiming.create(:user_id=>@user.id,:entry_time=>Time.now)
            		
	    flash[:message] = @timining.is_late? ? "You are late." :  "You have successfully signed in."
	  end
  	  redirect_to :action=> :home
	end

 	def total_analytics
	  @users = User.paginate(:page => params[:page], :per_page => 10).order("username ASC")
	  @user_time_arr = {}
	  @avg_time = UserTiming.avg_time_of_arrival
 	end

	def user_analytics
	  @user = User.find_by_id(params[:id])
	end











end
