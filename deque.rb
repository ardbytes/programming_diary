# Double ended queue
# https://www.youtube.com/watch?v=EU09CpPUrZc
# https://github.com/gammazero/deque/blob/main/deque.go

require 'minitest/autorun'
class Deque

  attr_reader :count

  MIN_CAPACITY = 16

  def initialize
    @array = []
    @head = 0
    @tail = 0
    @count = 0
  end

  def capacity
    @array.length
  end

  def push_back(el)
    grow_if_full
    @array[@tail] = el
    @tail = nexxt(@tail)
    @count += 1
  end

  def pop_back
    return if @count.zero?
    @tail = prev(@tail)
    el = @array[@tail]
    @array[@tail] = nil
    @count -= 1
    el
  end

  def push_front(el)
    grow_if_full
    @head = prev(@head)
    @array[@head] = el
    @count += 1
  end

  def pop_front
    return if @count.zero?
    el = @array[@head]
    @array[@head] = nil
    @count -= 1
    @head = nexxt(@head)
    el
  end

  def front
    @array[@head]
  end

  def back
    @array[prev(@tail)]
  end

  def nexxt(i)
    (i + 1) & (@array.length - 1)
  end

  def prev(i)
    (i - 1) & (@array.length - 1)
  end

  def grow_if_full
    if self.count == @array.length
      if self.count.zero?
        @array = Array.new(MIN_CAPACITY)
        return
      end
    end
  end
end

class TestDeque < Minitest::Test
  def setup
    @dq = Deque.new
  end

  def test_empty
    assert_nil(@dq.pop_back)
    assert_nil(@dq.pop_front)
    assert_equal(0, @dq.count)
    assert_equal(0, @dq.capacity)
  end

  def test_push_back
    @dq.push_back(10)
    assert_equal(1, @dq.count)
    assert_equal(10, @dq.back)
  end

  def test_push_front
    @dq.push_front(10)
    assert_equal(1, @dq.count)
    assert_equal(10, @dq.front)
  end

  def test_lifo
    @dq.push_back(10)
    @dq.push_back(20)
    assert_equal(20, @dq.pop_back)
    assert_equal(10, @dq.pop_back)

    @dq.push_front(10)
    @dq.push_front(20)
    assert_equal(20, @dq.pop_front)
    assert_equal(10, @dq.pop_front)

    assert_equal(0, @dq.count)
  end

  def test_fifo
    @dq.push_back(10)
    @dq.push_back(20)
    assert_equal(10, @dq.pop_front)
    assert_equal(20, @dq.pop_front)

    @dq.push_front(10)
    @dq.push_front(20)
    assert_equal(10, @dq.pop_back)
    assert_equal(20, @dq.pop_back)

    assert_equal(0, @dq.count)
  end
end
