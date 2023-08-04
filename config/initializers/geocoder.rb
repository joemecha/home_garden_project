Geocoder.configure(
  lookup: :mapquest,
  api_key: ENV['MAPQUEST_API_KEY'],
  use_https: true,
  units: :mi,
  time_zone: true
)
