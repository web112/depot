class ApplicationController < ActionController::Base

  skip_before_filter :authorize
  protect_from_forgery

  private
  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
    end

  def current_user
    return User.find(session[:user_id])
  end

  protected

  def authorize
    unless User.find_by_id(session[:user_id])
      redirect_to login_url, :notice => "Please log in"
    end
  end

  def host_authorize
    user = User.find_by_id(session[:user_id])
    unless user and user.role == "host"
      redirect_to login_url, :notice => "You are not the host. Please log in"
    end
  end

  def clerk_authorize
    user = User.find_by_id(session[:user_id])
    unless user and (user.role == "host" or user.role == "clerk")
      redirect_to login_url, :notice => "You are not the host or clerk. Please log in"
    end
  end

  def administrator_authorize
    user = User.find_by_id(session[:user_id])
    unless user and (user.role == "administrator")
      redirect_to login_url, :notice => "You are not the administrator. Please log in"
    end
  end

  def forbiden_authorize
    redirect_to login_url, :notice => "we are sorry the page is forbiden."
  end

end 



