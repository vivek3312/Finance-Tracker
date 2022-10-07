class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends ,through: :friendships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def under_stock_limit?
    stocks.count<=10
  end 
  def can_track_stock?(ticker_symbol)
     under_stock_limit? && !already_tracked_stock?(ticker_symbol)
  end 
  def already_tracked_stock?(ticker_symbol)
     stock=Stock.check_stock(ticker_symbol)
     return false unless stock
     stocks.where(id:stock.id).exists?
  end 
  def full_name
     return "#{first_name}#{last_name}" 
  end 
  def self.matches(field_param,param)
     where("#{field_param} like?","%#{param}%")
  end  
  def self.first_name_matches(param)
    matches('first_name',param)
  end

  def self.last_name_matches(param)
    matches('last_name',param)
  end

  def self.email_matches(param)
    matches('email',param)
  end

  def self.search(param)
    param.strip!
    serach_result= (first_name_matches(param) +last_name_matches(param)+email_matches(param)).uniq
    return nil unless serach_result
    serach_result
  end
   def except_current_user(users)
    users.reject{|user| user.id==self.id}
  end
   def not_friend_with?(id_of_friend)
    !friends.where(id:id_of_friend).exists?
  end
       
end
