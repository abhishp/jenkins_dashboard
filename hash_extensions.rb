class HashExtensions

  def self.indifferent_access(hash)
    return hash unless hash.is_a?(Hash)

    hash.default_proc = proc do |h, k|
      case k
        when String then
          sym = k.to_sym; h[sym] if h.key?(sym)
        when Symbol then
          str = k.to_s; h[str] if h.key?(str)
      end
    end
    hash.each_pair do |k, v|
      case v
        when Hash
           indifferent_access(v)
        when Array
          v.map { |o| indifferent_access(o) }
      end
    end
    hash
  end
end