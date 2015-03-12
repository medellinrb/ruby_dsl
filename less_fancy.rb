# Luis Edymerchk Laverde
# Daniel Munera
# Maria Isabel Zapata

class LessFancyMarkup
  def initialize
    @items = ''
  end

  def document(&block)
    puts "<html>\n#{instance_eval(&block)}\n</html>"
  end


  def item(text)
    @items << "\n\t\t\t\t<li>#{text}</li>"
  end

  def body(&block)
    "\t<body>\n#{instance_eval(&block)}\n\t</body>"
  end

  def div (hash, &block)
    "\t\t<div #{attrs(hash)}>\n#{instance_eval(&block)}\n\t\t</div>"
  end

  def list(hash, &block)
    instance_eval(&block)
    "\t\t\t<ul #{attrs(hash)}>\n#{@items[1..-1]}\n\t\t\t</ul>"
  end

  def attrs(hash)
    hash.inject(""){|result, hash| result << "'#{hash.first.to_s}' = '#{hash.last.to_s}'" }
  end
end

markup = LessFancyMarkup.new

html = markup.document do
  body do
    div id: 'container' do
      list class: 'pretty' do
        item 'item 1'
        item 'item 2'
      end
    end
  end
end

puts html
