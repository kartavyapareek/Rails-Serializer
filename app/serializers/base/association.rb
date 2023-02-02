# frozen_string_literal: true

module Base
  module Association
    class Config
      def initialize(attrs = nil)
        @attrs = attrs
      end

      def create_association_hash(type, association_hash)
        association_hash[type] = [] unless association_hash[type].present?
        association_hash[type] << { 'object' => @attrs[0], 'serializer' => @attrs[1][:serializer] }
        association_hash
      end

      def set_hash(association_hash) # rubocop:disable Naming/AccessorMethodName
        create_association_hash(self.class.to_s.split('::').last.underscore, association_hash)
      end

      def get_hash(association_hash, object) # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength
        result_hash = {}
        association_hash&.each do |key, value|
          case key
          when 'belongs_to', 'has_one'
            value.each do |v|
              result_hash.merge!({ v['object'] => v['serializer'].new(object.send(v['object'])).as_json })
            end
          when 'has_many'
            arr = []
            value.each do |v|
              object.send(v['object']).each do |res|
                arr << v['serializer'].new(res).as_json
              end
              result_hash.merge!({ v['object'] => arr })
            end
          end
        end
        result_hash
      end
    end

    class BelongsTo < Config
    end

    class HasOne < Config
    end

    class HasMany < Config
    end
  end
end
