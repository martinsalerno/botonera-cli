class Input
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def yes?
    value == Constants::YES
  end

  def no?
    value == Constants::NO
  end

  def is?(other)
    other == value
  end

  def ==(other)
    is?(other)
  end

  def eql?(other)
    is?(other)
  end

  def <=>(other)
    is?(other)
  end

  def hash
    value.hash
  end

  def to_s
    value
  end

  def to_str
    value
  end

  def method_missing(method, *args, &block)
    value.send(method, *args, &block)
  end
end
