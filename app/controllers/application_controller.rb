# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ConstraintRouter
  include Pundit
  include ConsentVerifier

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  helper_method :current_season
  helper_method :selected_season
  helper_method :current_driver
  helper_method :current_company

  before_action :authenticate_user!
  before_action :check_account!
  before_action :check_consents

  layout :determine_layout

  # Returns the Season that represents the actual season at point in time.
  def current_season
    @current_season ||= Season.new
  end

  def current_driver
    return nil unless user_signed_in?
    @current_driver ||= current_user.drivers.last
  end

  # @return [Company]
  def current_company
    return nil unless user_signed_in?
    # Currently only 1 company is supported
    @current_company ||= default_company_from_driver_or_user
  end

  # @param [Company | NilClass] company
  def current_company=(company)
    raise "must be a company" unless company.nil? || company.is_a?(Company)
    raise "company must be persisted" unless company.nil? || company.persisted?

    @current_company = company
  end

  def selected_season
    return @season if @season

    # update session
    session[:season] = params[:season] unless params[:season].blank?
    @season = session[:season] ? Season.from_sym(session[:season]) : current_season
  end

  def redirect_to_referral(fallback_location: nil)
    redirect_to session.delete(:return_to) || fallback_location
  end

  def store_referral
    session[:return_to] ||= request.referer
  end

  protected
    def pundit_user
      @auth_context || AuthContext.new(current_user, current_company, current_driver)
    end

    def user_not_authorized
      flash[:alert] = t("pundit.default")
      redirect_back(fallback_location: root_path)
    end

    def set_company_from_param
      self.current_company = Company.find_by(slug: params[:company_id])
    end

    def default_company_from_driver_or_user
      if current_driver&.company
        current_driver.company
      else
        current_user.companies.last
      end
    end

  private
    def determine_layout
      if user_signed_in?
        "application"
      else
        "public"
      end
    end
end
