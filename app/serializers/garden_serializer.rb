class GardenSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :size
end