# frozen_string_literal: true

#
# The most atomic way to train and run inference for a GPT in pure, dependency-free Ruby.
# This file is the complete algorithm.
# Everything else is just efficiency.
#
# Original: @karpathy
# Translated to Ruby: @ardbytes
#

# Let there be a Dataset `docs`: list[str] of documents (e.g. a list of names)

unless File.exist?('input.txt')
  names_url = 'https://raw.githubusercontent.com/karpathy/makemore/988aa59/names.txt'
  File.write('input.txt', URI.open(names_url).read)
end

docs = File.readlines('input.txt').map(&:strip).reject(&:empty?)
docs.shuffle!
puts "num docs: #{docs.length}"

# Let there be a Tokenizer to translate strings to sequences of integers ("tokens") and back
uchars = docs.join.chars.uniq.sort # unique characters in the dataset become token ids 0..n-1
BOS = uchars.length # token id for a special Beginning of Sequence (BOS) token
vocab_size = uchars.length + 1 # total number of unique tokens, +1 is for BOS
puts "vocab size: #{vocab_size}"

# Let there be Autograd to recursively apply the chain rule through a computation graph
class Value
  attr_accessor :data, :children, :local_grads

  def initialize(data, children = [], local_grads = [])
    self.data = data
    self.children = children
    self.local_grads = local_grads
  end

  def +(other)
    other = Value.new(other) unless other.is_a?(Value)
    Value.new(data + other.data, [self, other], [1, 1])
  end

  def coerce(other)
    [Value.new(other), self]
  end
end

v1 = Value.new(2)
v2 = v1 + 2
v3 = 3 + v1
puts("v1     = #{v1.data}")
puts("v1 + 2 = #{v2.data}")
puts("3 + v1 = #{v3.data}")
