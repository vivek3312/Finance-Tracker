class UserStocksController < ApplicationController
	def create
		   stock=Stock.new_lookup(params[:ticker])
		   @user_stock=UserStock.create(user:current_user,stock:stock)
		   flash[:notice]="Stocks has been inserted in myportfolio"
		   redirect_to my_portfolio_path
		
	   ''' else
		  flash[:notice]="Stocks already available"
		  redirect_to my_portfolio_path
	    end	'''
	end
	def destroy
		stock=Stock.find(params[:id])
		del_stock=UserStock.where(user_id:current_user.id,stock_id:stock.id).last 
	    del_stock.destroy
	    flash[:notice]="Associated stock has been removed"
	    redirect_to my_portfolio_path
	
	
	end	
end
=begin
user = User.first
	--> user.stocks
	--> stock=Stock.find(1)
	--> UserStock.all
	-->UserStock.where(user_id: user.id,stock_id:stock.id).first
	-->UserStock.where(user_id: user.id,stock_id:stock.id).first.destroy'''
=end