class UsersController < ApplicationController
  def my_portfolio
    @tracked_stock=current_user.stocks
  end
  def my_friends
    @friends=current_user.friends 
    @friends=current_user.except_current_user(@friends)

  end  
   def show
    @user = User.find(params[:id])
    @tracked_stock = @user.stocks
  end
  def search 
    if params[:friend].present?
      @friends=User.search(params[:friend])
      if @friends 
        render 'users/my_friends'
      else
        flash[:alert]="Kindly provide some valid keyword:"
        render 'users/my_friends'
      end
    else
      flash[:alert]="Kindly provide some keyword name:"
      render 'users/my_friends'
    end
  end     
end
