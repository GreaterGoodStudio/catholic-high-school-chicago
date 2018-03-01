Geocoder.configure(
  lookup: :mapbox,
  api_key: Rails.application.secrets.mapbox_access_token
)
