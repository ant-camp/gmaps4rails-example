class MapsController < ApplicationController
  def index

      search_params = {}
      #pagination
      search_params[:page] = params[:page]
      search_params[:per] = params[:per]

      #geocode params
      search_params[:location] = (params[:latitude] && params[:longitude]) if params[:latitude] && params[:longitude] unless search_params[:location].nil?
      search_params[:radius] = params[:radius] || 10


    #Geocoding search
      #if search_value.present?
        #geo = Geocoder.coordinates(params[:search])
         geo = Geocoder.coordinates('orlando')
      #  if !geo.nil?
        search_params[:coordinates] = {lat: geo.first,lon: geo.last, radius: params[:radius]}
          # search_params[:coordinates] = {lat: geo.first,lon: geo.last, radius: 10}
      #  end


      @search = Car.custom_search(search_params)

    @automobiles = @search.results
    @hash = Gmaps4rails.build_markers(@automobiles) do |auto, marker|
      marker.json({:id => auto.id})
      #marker latitude
      marker.lat auto.latitude
      #marker longitude
      marker.lng auto.longitude
      #marker infowindow
      #renders partial
      marker.infowindow render_to_string(:partial => "/map/infowindow", :locals => { :object => auto })
      #marker images
      #assets/images/map_marker
      #submodel of vehicle models represent the image
      marker.picture({ "url" => ("/assets/map_marker/#{auto.submodel}.png"), "height" => 40, "width" => 40 })

    end

    #unobtrusive JS
    #responses
    respond_to do |format|
      format.html
      format.js
    end
  end
end
