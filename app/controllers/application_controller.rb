class ApplicationController < ActionController::Base

  skip_before_filter :authorize
  protect_from_forgery

=begin
  before_filter :set_i18n_locale_from_params

  protected
  def set_i18n_locale_from_params
  if params[:locale]
  if I18n.available_locales.include?(params[:locale].to_sym)
  I18n.locale=params[:locale]
  else
  flash.now[:notice]=
  "#{params[:locale]} translation not available"
  logger.error flash.now[:notice]
  end
  end
  end
  def defaule_url_options
    {:locale=>I18n.locale}
  end
=end

  before_filter :set_locale

  protected
  def set_locale
    session[:locale] = params[:locale] if params[:locale]
    I18n.locale = session[:locale] || I18n.default_locale
    locale_path = "#{LOCALES_DIRECTORY}#{I18n.locale}.yml"
    unless I18n.load_path.include? locale_path
      I18n.load_path << locale_path
      I18n.backend.send(:init_translations)
    end
    
  rescue Exception => err
    logger.error err
    flash.now[:notice] = "#{I18n.locale} translation not available"
    I18n.load_path -= [locale_path]
    I18n.locale = session[:locale] = I18n.default_locale
  end

  

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

