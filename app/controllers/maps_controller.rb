class MapsController < ApplicationController
  def index


      @search = Vehicle.custom_search(search_params)

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
      if auto.submodel.present?
        marker.picture({ "url" => ("/assets/map_marker/#{auto.model.submodel}.png"), "height" => 40, "width" => 40 })
      end
    end

    #unobtrusive JS
    #responses
    respond_to do |format|
      format.html
      format.js
    end
  end
end
