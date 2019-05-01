module Bidder
  def accepted_requests
    request_bids.accepted.map &:requests
  end
end
