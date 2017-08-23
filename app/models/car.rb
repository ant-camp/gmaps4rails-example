class Car < ActiveRecord::Base
  belongs_to :car_make
  belongs_to :car_model

  #make_name, model_name are all part of sunspot solr search
  #we can simply add the parmas to the map controller index method
  #used to search on map/index
  def make_name
    self.make.name if make
  end

  def model_name
    self.model.name if model
  end


  searchable do
    latlon(:location) { Sunspot::Util::Coordinates.new(latitude, longitude) }
  end


    # Optional params
    # param options [Hash]
    # option make [Integer] - id of a Make instance
    # ..
    # ...
    # option coordinates [Hash] - expects hash with :lat, :lon, :radius keys (radius in miles)
    def self.custom_search(options={})


      if coords = options.delete(:coordinates)
        default_distance = 30
        if !coords[:radius].nil?
          default_distance = coords[:radius].to_f || 30
        end
        kilos   = 1.609 * default_distance
      end

      # binding.pry

      Car.solr_search do

        with(:location).in_radius(coords[:lat],coords[:lon],kilos, :bbox => true) if coords


        paginate :page => (options[:page] || 1), :per_page => 40


      end
    end
end
