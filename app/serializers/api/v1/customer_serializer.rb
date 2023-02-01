# frozen_string_literal: true

module Api
  module V1
    class CustomerSerializer < SimpleSerializer
      attributes :id,
                 :first_name,
                 :last_name
    end
  end
end
