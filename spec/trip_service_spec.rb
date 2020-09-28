require 'rspec'
require_relative '../trip/trip_service'
require_relative '../trip/trip'

describe TripService do
  let(:trip_service) { TripService.new }
  let(:session) { class_double(UserSession).as_stubbed_const }

  context "when no user is logged in" do
    it "raises a not logged in exception" do
      expect { trip_service.get_trip_by_user(User.new, logged_user: nil) }.to raise_error(UserNotLoggedInException)
    end
  end

  context "when user is logged in" do
    let(:logged_user) { User.new }
    let(:user) { instance_double(User, :friend? => false) }
    let(:trip) { Trip.new }

    before do
      allow(TripDAO).to receive(:find_trips_by_user).with(user).and_return([trip])
    end

    it "returns an empty trip list when requesting trips of a user that is not a friend" do
      trip_list = trip_service.get_trip_by_user(user, logged_user: logged_user)
      expect(trip_list).to be_empty
    end

    it "returns the actual trips of a friend user" do
      allow(user).to receive(:friend?).with(logged_user).and_return(true)
      trip_list = trip_service.get_trip_by_user(user, logged_user: logged_user)
      expect(trip_list).to contain_exactly(trip)
    end
  end
end
