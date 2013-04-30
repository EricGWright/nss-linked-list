require 'linked_list_item'

class LinkedList
  attr_reader :first_item

  def initialize *args
    args.each do | payload |
      add_item(payload)
    end
  end

  def add_item(payload)
    new_item = LinkedListItem.new(payload)
    if @first_item.nil?
      @first_item = new_item
    else
      item = @first_item
      until item.last?
        item = item.next_list_item
      end
      item.next_list_item = new_item
    end
  end

  def get_item(n)
    raise IndexError if n < 0
    item = @first_item
    n.times do
      raise IndexError if item.nil?
      item = item.next_list_item
    end
    item
  end

  def get(n)
    get_item(n).payload
  end

  def last
    return nil if @first_item.nil?
    item = @first_item
    until item.last?
      item = item.next_list_item
    end
    item.payload
  end

  def size
    item = @first_item
    size = 0
    until item.nil?
      item = item.next_list_item
      size += 1
    end
    size
  end

  def to_s
    return "| |" if @first_item.nil?
    item_list = "#{@first_item.payload}"
    item = @first_item.next_list_item
    until item.nil?
      item_list += ", #{item.payload}"
      item = item.next_list_item
    end
    "| #{item_list} |"
  end

# ========= Bonus ========== #

  def [](n)
    get(n)
  end

  def []=(n, payload)
    prev = get_item(n-1)
    oldnext = prev.next_list_item
    newnext = LinkedListItem.new(payload)
    prev.next_list_item = newnext
    newnext.next_list_item = oldnext.next_list_item
  end

  def remove(n)
    if n == 0
      raise IndexError if @first_item.nil?
      @first_item = @first_item.next_list_item
    else
      previous_item = @first_item
      (n - 1).times do
        raise IndexError if previous_item.nil?
        previous_item = previous_item.next_list_item
      end
      raise IndexError if previous_item.nil? or previous_item.last?
      next_item = previous_item.next_list_item.next_list_item
      previous_item.next_list_item = next_item
    end
  end

  # ========= Index Exercise ========== #

  def indexOf(payload)
    item = @first_item
    index = 0
    until item.nil?
      return index if payload == item.payload
      item = item.next_list_item
      index += 1
    end
    nil
  end

    # ========= Sorting Exercise ========== #

  def sorted?
    item = @first_item
    return true unless item
    while item
      return true if item.last?
      return false if item > item.next_list_item
      item = item.next_list_item
    end
  end

  def sort
  end

  def swap_with_next i
    raise IndexError if i + 1 >= size
    current_item = get_item(i)
    next_item = get_item(i+1)

    if i - 1 >= 0
      previous_item = get_item( i-1)
      previous_item.next_list_item = next_item
    else
      @first_item = next_item
    end

    current_item.next_list_item = next_item.next_list_item
    next_item.next_list_item = current_item
  end

end
