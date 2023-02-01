# frozen_string_literal: true

module Api
  module V1
    class ProductSerializer < SimpleSerializer
      attributes :id,
                 :number
    end
  end
end
