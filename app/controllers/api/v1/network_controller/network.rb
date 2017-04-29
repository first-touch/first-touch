class Api::V1::NetworkController
  class Network
    include ActiveModel::Serialization

    attr_reader :followers, :following

    def initialize(network)
      @followers = network[:followers]
      @following = network[:following]
    end
  end
end
