# -*- coding: utf-8 -*-
class FancyMarkup
  # mapeamos el nombre de cada método a un elemento HTML.
  WHITELIST_TAGS = { body: "body", div: "div", list: "ul", item: "li" }

  def document
    @result = ""
    yield
  end

  def to_html
    "<html>#{@result}</html>"
  end

  # es un kata!
  def method_missing(name, *args, **kwargs)
    return(super) unless WHITELIST_TAGS.has_key?(name)

    tag_name = WHITELIST_TAGS[name]
    value = args[0]
    options = kwargs

    if block_given?
      inner_content = yield
      @result = build_html(tag_name, "#{value}#{inner_content}", options)
    else
      @result << build_html(tag_name, value, options)
    end
  end

  # identamos si hay nokogiri instalado
  def inspect
    begin
      pretty_print
    rescue Gem::LoadError
      to_html
    end
  end

  protected
  # formateamos y llenamos el "template"
  def build_html(tag_name, value, options={})
    attr = options.map { |name, value| "#{name}=\"#{value}\""}.join(" ")

    # somos neuróticos, no podemos tolerar vacíos en <div >, <body >, etc.
    attr = " #{attr}" unless attr.empty?

    "<#{tag_name}#{attr}>#{value}</#{tag_name}>"
  end

  def pretty_print
    gem 'nokogiri'
    require 'nokogiri'
    Nokogiri.XML(to_html,&:noblanks).to_xhtml
  end
end

@markup = FancyMarkup.new
@markup.document do
  @markup.body do
    @markup.div id: 'container' do
      @markup.list class: "pretty" do
        @markup.item "item 1"
        @markup.item "item 2"
      end
    end
  end
end

p @markup
