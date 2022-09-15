class Nonogram
  attr_reader :data
  attr_reader :width
  attr_reader :height

  def initialize(data)
    @data = data
    @width = data[0].size
    @height = data.size
  end

  def to_s
    base64 = [*'0'..'9', *'a'..'z', *'A'..'Z', '-', '_']

    @data
    .join.then { _1 + '0' * (_1.size % 6) }
    .chars.each_slice(6).map(&:join)
    .map { _1.to_i(2) }
    .map { base64[_1] }
    .join.then { "#{@width}x#{@height}.#{_1}" }
  end

  def puzzle
    clue_generator = lambda do |data|
      data.map do |line|
        line.chars.chunk { _1 }
        .map { _1 == '1' ? _2.size : nil }
        .compact
      end
    end

    clue_lines = clue_generator.call(@data)
    clue_column = clue_generator.call(@data.map(&:chars).transpose.map(&:join))

    [clue_lines, clue_column]
  end
end

class String
  def to_nonogram
    base64 = [*'0'..'9', *'a'..'z', *'A'..'Z', '-', '_']

    size, data = self.split('.')
    width, height = size.split('x')
    data.chars
    .map { base64.index(_1) }
    .map { _1.to_s(2).rjust(6, '0') }
    .join.chars.each_slice(width.to_i).map(&:join).first(height.to_i)
  end
end

nonogram = Nonogram.new(%w[
  010001
  100010
  111110
  110110
])

p (p nonogram.to_s).to_nonogram
p nonogram.puzzle