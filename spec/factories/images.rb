FactoryBot.define do
  factory :image do
    file { File.new("#{Rails.root}/spec/support/fixtures/image.jpg") }
  end
end
