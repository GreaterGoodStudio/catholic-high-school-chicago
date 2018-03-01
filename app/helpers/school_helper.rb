module SchoolHelper
  def directions_url(address)
    "https://www.google.com/maps/dir/?api=1&destination=#{CGI.escape address}"
  end
end
