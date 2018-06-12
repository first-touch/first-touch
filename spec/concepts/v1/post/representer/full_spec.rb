require 'rails_helper'

describe V1::Post::Representer::Full do
  let(:model) { build :post }

  describe 'Full' do
    let(:representer_class) { ::V1::Post::Representer::Full }
    let(:expected_schema) { 'posts/full' }
    it_behaves_like 'json representer'
  end
end
