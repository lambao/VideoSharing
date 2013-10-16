class ManageUsersController < ApplicationController
  before_filter :authenticate_user!
  def index
    if !(current_user.has_role?(:admin))
      flash[:error] = "You dont have right to access this page"
      redirect_to root_path
    end
     @users = User.all
  end

  def edit
    if !(current_user.has_role?(:admin))
      flash[:error] = "You dont have right to access this page"
      redirect_to root_path
    end
  	@user = User.find(params[:id])
  end

  def update
    if !(current_user.has_role?(:admin))
      flash[:error] = "You dont have right to access this page"
      redirect_to root_path
    end
  	@user = User.find(params[:id])
  	if (params[:role] == "admin")
  		if @user.has_role?(:guest)
  			@user.remove_role(:guest)
  		end
  		if @user.has_role?(:admin)
  			@user.remove_role(:admin)
  		end
  		@user.add_role(:admin)
  	end
  	if (params[:role] == "guest")
  		if @user.has_role?(:admin)
  			@user.remove_role(:admin)
  		end
  		if @user.has_role?(:guest)
  			@user.remove_role(:guest)
  		end
  		@user.add_role(:guest)
  	end
  	flash[:success] = "Update success"
    redirect_to user_list_path
  end
end
