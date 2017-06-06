class ReservationsController < ApplicationController
  
  def new
  	@date = DateSegment.find_by(id: params['date_seg'])
  end

  def create
  	time = TimeSegment.find_by(id: params["time"])
  	user = User.find_by(id: session["user_id"])
  	if time.update_attribute(:table_left, time.table_left-1)
	  	reservation = Reservation.new
	  	reservation.user_id = User.find_by(id: session["user_id"]).id
	  	reservation.time_segment = TimeSegment.find_by(id: params["time"])
	  	reservation.size = params["size"]
  	
	  	if reservation.save
	  		user.update_attribute(:points, user.points + reservation.size.to_i)
	  		user.errors.full_messages.each do |message|
  				puts message
  			end
	  		redirect_to "/restaurants/#{reservation.time_segment.restaurant_id}", notice: "Succeed"
	  	else
	  		redirect_to "/restaurants/#{reservation.time_segment.restaurant_id}", notice: "Creation Failed"	
	  		reservation.errors.full_messages.each do |message|
  				puts message
  			end
  		end
  	else
  		redirect_to "/restaurants/#{reservation.time_segment.restaurant_id}", notice: "Time is full"
  		time.errors.full_messages.each do |message|
  			puts message
  		end
  	end
  end

  def update
  	@user = User.find_by(id: session["user_id"])
  	@reservation = Reservation.find_by(id: params["id"])
  	@reservation.update_attribute(:review, params["review"])
  	redirect_to "/reservations", notice: "Review saved"
  end

  def edit
  	@reservation = Reservation.find_by(id: params["id"])
  end

  def index
  	@user = User.find_by(id: session["user_id"])
    currentTime = Time.new(2017, 6, 3)
  	if not @user.present?
  		redirect_to "/login", notice: "Please sign in first"
  	end
  end

  def destroy
    puts "destroy"
  	@reservation = Reservation.find_by(id: params["id"])
  	user = User.find_by(id: session["user_id"])
  	destroyed = @reservation.destroy
  	if destroyed
  		time_seg = TimeSegment.find_by(id: destroyed.time_segment_id)
  		time_seg.table_left += 1
  		time_seg.save
  		user.update_attribute(:points, @reservation.size.to_i)
  		redirect_to "/reservations", notice: "Canceled"
  	else
  		redirect_to "/reservations", notice: "Faild"
  	end
  end

  def all
    @user = User.find_by(id: session["user_id"])
    if not @user.present?
      redirect_to "/login", notice: "Please sign in first"
    end
    if not @user.admin
      redirect_to "/", notice: "Unauthorized"
    end

    @reservations = Reservation.all.page(params[:page]).per(50)

  end

end
