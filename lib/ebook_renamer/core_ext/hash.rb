class Hash

  # File activesupport/lib/active_support/core_ext/hash/keys.rb
  #
  # hash = { name: 'Rob', age: '28' }
  # hash.transform_keys{ |key| key.to_s.upcase }
  # => { "NAME" => "Rob", "AGE" => "28" }
  def transform_keys
    result = {}
    each_key do |key|
      result[yield(key)] = self[key]
    end
    result
  end

  def transform_keys!(&block)
    keys.each do |key|
      value = delete(key)
      self[yield(key)] = value.is_a?(Hash) ? value.transform_keys!(&block) : value
    end
    self
  end

  # hash = { 'name' => 'Rob', 'age' => '28' }
  # hash.symbolize_keys
  # => { name: "Rob", age: "28" }
  def symbolize_keys
    transform_keys{ |key| key.to_sym rescue key }
  end

  # File activesupport/lib/active_support/core_ext/hash/keys.rb, line 135
  def symbolize_keys!
    transform_keys!{ |key| key.to_sym rescue key }
  end

  # Merges the caller into +other_hash+. For example,
  #
  #   options = options.reverse_merge(size: 25, velocity: 10)
  #
  # is equivalent to
  #
  #   options = { size: 25, velocity: 10 }.merge(options)
  #
  # This is particularly useful for initializing an options hash
  # with default values.
  def reverse_merge(other_hash)
    other_hash.merge(self)
  end

  # Destructive +reverse_merge+.
  def reverse_merge!(other_hash)
    # right wins if there is no left
    merge!(other_hash) { |key,left,right| left }
  end

end
