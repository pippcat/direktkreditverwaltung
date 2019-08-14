class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :load_association

  private
  def load_association
    @association = Association.first #TODO this will be replaced by current_user.association some time later
  end

end
