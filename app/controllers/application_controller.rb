class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern
  # before_action :set_current_user
  # helper_method :current_user  # <-- Add this line

  def paginate(scope, per_page: 1)
    page = params[:page].presence&.to_i || 1
    page = 1 if page < 1
    offset = (page - 1) * per_page 

    paginated_records = scope.offset(offset).limit(per_page)
    total_pages = (scope.count.to_f / per_page).ceil
    return paginated_records, total_pages, page
  end
end
