require_relative '../еxceptions/dependent_class_call_during_unit_test_exception'

class UserSession
    @@user_session = UserSession.new

    def self.get_instance
        @@user_session
    end

    def is_user_logged_in(user)
        raise DependentClassCallDuringUnitTestException.new('UserSession.is_user_logged_in should not be called in an unit test')
    end

    def get_logged_user
        raise DependentClassCallDuringUnitTestException.new('UserSession.get_logged_user should not be called in an unit test')
    end

    private_class_method :new
end
