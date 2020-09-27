require_relative '../еxceptions/dependent_class_call_during_unit_test_exception'

class TripDAO
    def self.find_trips_by_user(user)
        raise DependentClassCallDuringUnitTestException.new('TripDAO should not be invoked on an unit test.')
    end
end
