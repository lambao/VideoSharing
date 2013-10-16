class ManageUsersController < ApplicationController
  def index
     @users = User.all
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
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
