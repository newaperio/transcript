class ApplicationController < ActionController::Base
  include Transcript::Controller

  protect_from_forgery with: :exception
end
