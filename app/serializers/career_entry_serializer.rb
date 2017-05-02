class CareerEntrySerializer < ActiveModel::Serializer
  attributes :id, :start_date, :end_date
  has_one :club
end
