class LocationSerializer
  include FastJsonapi::ObjectSerializer

  def self.format(data)
    {
      lat: data[:results][0][:locations][0][:latLng][:lat],
      lon: data[:results][0][:locations][0][:latLng][:lng],
    }
  end
end
