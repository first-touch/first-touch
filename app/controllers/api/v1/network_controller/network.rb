class Api::V1::NetworkController
  class Network
    include ActiveModel::Serialization

    attr_accessor :followers, :following

    def initialize(network)
      @followers = network[:followers]
      @following = network[:following]
    end
  end
end
