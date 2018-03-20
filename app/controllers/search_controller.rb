class SearchController < ApplicationController
  def index
    @query = determine_query
    @zipcode = determine_zipcode
    
    find_schools

    respond_to do |format|
      format.html
      format.json { render json: { schools: @schools_json, bookmark: bookmark } }
    end
  end

  private
    def search_params
      params.permit(:zipcode, :token, :locale, q: {})
    end

    def decoded_token
      @decoded_token ||= SearchToken.decode(search_params[:token])
    end

    def determine_query
      decoded_token.try(:fetch, "query") || search_params[:q] || default_query
    end

    def determine_zipcode
      decoded_token.try(:fetch, "zipcode") || search_params[:zipcode]
    end

    def find_schools
      @schools = School.with_translations(I18n.locale).ransack(@query).result(distinct: true)
      @schools_json = ActiveModelSerializers::SerializableResource.new(@schools).to_json
    end

    def bookmark
      token = SearchToken.encode({ query: @query.to_h, zipcode: @zipcode })
      Rails.application.routes.url_helpers.bookmark_path(token: token, locale: I18n.locale)
    end

    def default_query
      I18n.t(:search_filters).keys.inject({}) {|h, k| h.merge!("translations_#{k}_cont_all" => [])}
    end
end
