module JsDuck

  # Detects the type of documentation object: class, method, cfg, etc
  class BaseType
    # Given parsed documentation and code, returns the tagname for
    # documentation item.
    #
    # @param doc_map Result from DocParser turned into hash of tags.
    # @param code Result from Ast#detect or CssParser#parse
    # @returns One of: :class, :method, :event, :cfg, :property, :css_var, :css_mixin
    #
    def self.detect(doc_map, code)
      if doc_map[:class] || doc_map[:override]
        :class
      elsif doc_map[:event]
        :event
      elsif doc_map[:method]
        :method
      elsif doc_map[:property] || doc_map[:type]
        :property
      elsif doc_map[:css_var]
        :css_var
      elsif doc_map[:cfg] && doc_map[:cfg].length == 1
        # When just one @cfg, avoid treating it as @class
        :cfg
      elsif code[:tagname] == :class
        :class
      elsif code[:tagname] == :css_mixin
        :css_mixin
      elsif doc_map[:cfg]
        :cfg
      elsif doc_map[:constructor]
        :method
      elsif doc_map[:param] || doc_map[:return]
        :method
      else
        code[:tagname]
      end
    end
  end

end