class BackgroundFacade
  class << self

    def get_background(location)
      data = UnsplashService.get_background(location)
      BackgroundSerializer.format(data)
    end

  end
end
