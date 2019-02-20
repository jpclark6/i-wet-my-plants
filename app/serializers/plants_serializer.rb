class PlantsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id
  attribute :secret do |plant|
    message = "#{plant.id}.#{1.hour.from_now}"
    key = Digest::SHA256.hexdigest "#{message}#{ENV['HARDWARE_SECRET_API']}"
    "#{message}.#{key}"
  end
end
