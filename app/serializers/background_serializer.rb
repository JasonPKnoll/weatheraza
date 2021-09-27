class BackgroundSerializer
  include FastJsonapi::ObjectSerializer

  def self.format(data)
    {
      data: {
        id: nil,
        type: 'image',
        attributes: {
          image: {
            full_image: data[:results][0][:urls][:full],
            regular_image: data[:results][0][:urls][:regular],
            description: data[:results][0][:description],
            author: data[:results][0][:user][:name]
          }
        }
      }
    }
  end
end
