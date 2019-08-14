module PdfHelper
  include ApplicationHelper
  include ActionView::Helpers::NumberHelper

  private
  def association
    @association = Association.find :first
  end

end
