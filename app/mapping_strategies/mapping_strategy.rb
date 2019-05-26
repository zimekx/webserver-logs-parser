class MappingStrategy
  attr_reader :key, :value

  def initialize(_)
    raise NotImplementedError
  end
end