class DependentClassCallDuringUnitTestException < StandardError
    def initialize(msg)
        super(msg)
    end
end
