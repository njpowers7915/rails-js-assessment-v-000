class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      #if user_params[:admin] == "0"
        session[:user_id] = @user.id
        #format.html { redirect_to @user, notice: "Welcome to APP NAME!" }
        redirect_to @user
      #elsif user_params[:admin] == "1"
      #  admin_signup
      #end
    else
      render 'new'
      #format.html { render :new }
    end
  end

  def show
    if User.find_by_id(session[:user_id])
      @user = User.find_by_id(session[:user_id])
      #@attraction = Attraction.find_by_id(session[:attraction_id])

    else
      redirect_to '/'
    end
  end

  def edit
  end

  def update
    respond_to do |format|
    if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
    else
        format.html { render :edit }
    end
  end



  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :admin)
  end

end
