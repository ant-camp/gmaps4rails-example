class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :year
      t.string :submodel
      t.float :latitude, {:precision=>10, :scale=>6}
      t.float :longitude, {:precision=>10, :scale=>6}
      t.references :car_make, index: true
      t.references :car_model, index: true
      t.timestamps
    end
  end
end
