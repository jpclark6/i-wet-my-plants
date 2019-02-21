class PlantsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id
  attribute :secret do |plant|
    Key.create_water_key(plant)
  end
end
