class BeermappingApi
  def self.places_in(city)
    city = city.downcase
    Rails.cache.fetch(city, :expires_in => 30.seconds) { fetch_places_in(city) }
  end

  private

  def self.fetch_places_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{city.gsub(' ', '%20')}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.inject([]) do | set, place |
      set << Place.new(place)
    end
  end
  
  def self.fetch_place(id)
  	url = "http://beermapping.com/webservice/locquery/#{key}/"
  	response = HTTParty.get "#{url}#{id.to_s}"
  	place = response.parsed_response["bmp_locations"]["location"]
  	
  	return nil if place.is_a?(Hash) && place["id"] == nil
  	return Place.new(place)
  end
  
  def self.key
    return Settings.beermapping_apikey
    #return "7c8065382b8a5cd72381d804120d7e89"
  end
end