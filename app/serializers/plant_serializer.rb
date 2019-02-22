class PlantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :species
  attribute :secret do |plant|
    Key.create_water_key(plant)
  end
end
