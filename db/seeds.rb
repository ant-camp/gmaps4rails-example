json = JSON.parse(File.read(File.expand_path("../../db/seeds/automobile.json", __FILE__)))
automobiles = json["automobiles"]

automobiles.each do |auto|

car = Car.new
  car.submodel = auto["submodel"]
  car.year = auto["year"]

 make = CarMake.new
  make.name = auto["make"]
  make.save

 model = CarModel.new
  model.name = auto["model"]
  model.save

  car.save!

end
