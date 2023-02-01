# frozen_string_literal: true

Product = Struct.new(:id, :number) do
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
