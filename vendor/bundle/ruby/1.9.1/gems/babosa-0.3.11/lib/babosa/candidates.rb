require 'securerandom'

module Babosa

  # This iterates through slug candidates and generates them lazily. In other
  # words, if the first candidate succeeds, the remaning ones are not
  # evaluated.  It also appends a fallback candidate which uses the final
  # candidate's slug plus a GUID.
  class Candidates

    include Enumerable

    def initialize(object, *array)
      @candidates = to_candidate_array(object, array.flatten(1))
      @candidates << (@candidates.last.dup << -> {SecureRandom.uuid})
    end

    def each(*args, &block)
      @candidates.each(*args) do |candidate|
        yield candidate.map(&:call).join(' ').to_slug.normalize!
      end
    end

    private

    def to_candidate_array(object, array)
      array.map do |candidate|
        case candidate
        when String
          [->{candidate}]
        when Array
          to_candidate_array(object, candidate).flatten
        when Symbol
          [object.method(candidate)]
        else
          if candidate.respond_to?(:call)
            [candidate]
          else
            [->{candidate.to_s}]
          end
        end
      end
    end
  end
end