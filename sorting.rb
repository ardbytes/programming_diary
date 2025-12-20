################################ Merge Sort Begin ##############################

def merge(l, r)
  i = 0
  j = 0
  m = l.length
  n = r.length
  a = []
  while i < m or j < n
    if i == m
      a += r[j..]
      j = n
    elsif j == n
      a += l[i..]
      i = m
    elsif l[i] < r[j]
      a << l[i]
      i += 1
    else
      a << r[j]
      j += 1
    end
  end
  a
end

def merge_sort(a)
  if a.length <= 1
    a
  else
    l = merge_sort(a[0..a.length/2-1])
    r = merge_sort(a[a.length/2..])
    merge(Array(l), Array(r))
  end
end

################################ Merge Sort End ################################

################################ Heap Sort Begin ###############################
def heapify(a, n, i)
  largest = i
  left = 2*i+1
  right = 2*i+2
  if left < n && a[left] > a[i]
    largest = left
  end

  if right < n && a[right] > a[largest]
    largest = right
  end

  if largest != i
    a[i], a[largest] = a[largest], a[i]
    heapify(a, n, largest)
  end
end

def heap_sort(a)
  a = a.dup
  (a.length/2 - 1).downto(0) do |i|
    heapify(a, a.length, i)
  end
  (a.length - 1).downto(0) do |i|
    a[0], a[i] = a[i], a[0]
    heapify(a, i, 0)
  end
  a
end

################################ Heap Sort End #################################

10.times do
  a = (1..999).to_a.shuffle

  if(merge_sort(a) == heap_sort(a))
    next
  else
    puts "Something wrong on #{a}"
  end
end
