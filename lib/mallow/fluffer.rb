module Mallow
  class Fluffer
    attr_accessor :config, :rules
    DeserializationException = Class.new StandardError

    def initialize(rules)
      @rules = rules
    end

    def parse(str)
      fluff Mallow.parser.send(Mallow.verb, str)
    end

    def parse_one(str)
      fluff_one Mallow.parser.send(Mallow.verb, str)
    end

    def fluff(elts)
      elts.map {|elt| fluff_one elt}
    end

    def fluff_one(elt)
      rules.each do |rule|
        res = rule.execute elt
        return res.value if res.success
      end
      raise DeserializationException.new "No rule matches #{elt}"
    end

    def self.build(&blk)
      new(Rule::Builder.build &blk)
    end

  end
end
