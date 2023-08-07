# # app/models/concerns/timezone_lookup.rb
# module TimezoneLookup
#   extend ActiveSupport::Concern

#   module ClassMethods
#     def lookup(latitude, longitude)
#       tz = ::Timezone.lookup(latitude, longitude)
#       tz.name if tz
#     end
#   end
# end
