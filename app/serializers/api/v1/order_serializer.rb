# frozen_string_literal: true

module Api
  module V1
    class OrderSerializer < SimpleSerializer
      iso_timestamp_columns %i[created_at updated_at delivery_time]
      attributes :id,
                 :status,
                 :value,
                 :delivery_time,
                 :notes,
                 :created_at,
                 :updated_at

      belongs_to :company,  serializer: Api::V1::CompanySerializer
      has_one    :customer, serializer: Api::V1::CustomerSerializer
      has_many   :products, serializer: Api::V1::ProductSerializer

      def notes
        @object.notes.presence
      end
    end
  end
end
