def random_array(el)
  1000.times.collect do |x|
    rand(10000)
  end.tap do |arr|
    arr.uniq!
    unless arr.index(el)
      arr << el
    end
    arr.sort!
  end
end

def _binary_search(array, el, l, r)
  if l > r
    return
  end
  mid = (l + r) / 2
  if array[mid] == el
    mid
  elsif array[mid] < el
    _binary_search(array, el, mid+1, r)
  elsif array[mid] > el
    _binary_search(array, el, l, mid-1)
  end
end

def binary_search(array, el)
  _binary_search(array, el, 0, array.length-1)
end

100.times do
  el = rand(10000)
  array = random_array(el)

  idx = binary_search(array, el)
  value = array.index(el)

  if idx != value
    puts "Expected #{value}, but got #{idx}"
    break
  end
end
