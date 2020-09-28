require_relative '../trip/trip_dao'
require_relative '../user/user_session'
require_relative '../user/user'
require_relative '../еxceptions/user_not_logged_in_exception'
require_relative '../еxceptions/dependent_class_call_during_unit_test_exception'

class TripService
  def get_trip_by_user(user)
    logged_user = UserSession.get_instance.get_logged_user
    raise UserNotLoggedInException.new if logged_user.nil?

    trip_list = []
    if(user.friend?(logged_user))
      trip_list = TripDAO.find_trips_by_user(user)
    end

    return trip_list
  end
end
