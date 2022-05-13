require 'rails_helper'

RSpec.describe AuthenticationTokenService do
  describe '.encode' do
    it 'returns an authentication token' do
      token = described_class.encode
      decoded_token = JWT.decode(
        token,
        described_class::HMAC_SECRET,
        true,
        { algorithm: described_class::ALGORITHM_TYPE }
      )
      expect(decoded_token).to eq(
        [
          { 'test' => 'blah' },
          { 'alg' => 'HS256' }
        ]
      )
    end
  end
end
