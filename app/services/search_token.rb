class SearchToken
  class << self
    def encode(payload)
      JWT.encode payload, nil, "none"
    end

    def decode(payload)
      return unless payload.present?
      JWT.decode(payload, nil, false).first
    end
  end
end