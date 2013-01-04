require "jsduck/tag/boolean_tag"

module JsDuck::Tag
  class Static < BooleanTag
    def initialize
      @key = :static
      @signature = {:long => "static", :short => "STA"}
      super
    end
  end
end