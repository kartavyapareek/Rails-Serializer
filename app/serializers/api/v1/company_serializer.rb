# frozen_string_literal: true

module Api
  module V1
    class CompanySerializer < SimpleSerializer
      attributes :id,
                 :name,
                 :address

      def address
        @object.address || 'No Address Found'
      end
    end
  end
end
