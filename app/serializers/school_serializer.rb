class SchoolSerializer < ActiveModel::Serializer
  attributes :id, :name, :slug, :address, :coordinates, :path

  def path
    Rails.application.routes.url_helpers.school_path(object, locale: I18n.locale)
  end
end
