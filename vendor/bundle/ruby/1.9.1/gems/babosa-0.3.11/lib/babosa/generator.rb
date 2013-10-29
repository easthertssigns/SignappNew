require 'set'

module Babosa
  # A simple slug generator using a Set as a backend. Obviously this is silly
  # and potentially a great way to leak memory, but it demonstrates the
  # funcionality.
  class Generator
    def initialize
      @set = Set.new
    end

    def available?(slug)
      !@set.member?(slug)
    end

    def add(slug)
      @set.add slug; slug
    end

    def generate(candidates)
      candidates.each {|c| return add c if available?(c)}
    end
  end
end