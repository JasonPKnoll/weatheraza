class MapQuestFacade
  class << self
    def get_geocoding(location)
      data = MapQuestService.get_geocoding(location)
      format_location = LocationSerializer.format(data)
    end

  end
end
