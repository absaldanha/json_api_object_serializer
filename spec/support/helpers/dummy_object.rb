# frozen_string_literal: true

module DummyObject
  def dummy_object(id: nil, attributes: {})
    Class.new do
      define_method :id do
        id
      end

      attributes.each do |key, value|
        define_method key do
          value
        end
      end
    end.new
  end
end
