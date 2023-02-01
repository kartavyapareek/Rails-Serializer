# frozen_string_literal: true

Order = Struct.new(:id, :status, :value, :delivery_time, :notes, :customer, :company, :products) do
  def id
    self[:id].presence || SecureRandom.uuid
  end

  def created_at
    Time.current
  end

  def updated_at
    Time.current
  end
end
