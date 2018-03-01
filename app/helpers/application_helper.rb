module ApplicationHelper
  def alt_locale_path
    alt_locale = params[:locale] == "en" && "es" || "en"
    request.path.sub(/(es|en)/, alt_locale)
  end
end
