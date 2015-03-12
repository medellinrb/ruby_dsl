# Luis Edymerchk Laverde
# Daniel Munera
# Maria Isabel Zapata

class MissingMarkup
  def initialize
    @items = ''
    @mapping ={document: 'html', body: 'body', list: 'ul', item: 'li', div: 'div'}
    @counter = 0
  end

  def attrs(hash)
    hash.inject(" "){|result, hash| result << "'#{hash.first.to_s}' = '#{hash.last.to_s}'" } unless hash.nil?
  end

  def method_missing(name, *args, &block)
     tabs = "\t" * @counter
    if block_given?
      @counter += 1
      "#{tabs}<#{@mapping[name]}#{attrs(args.first)}>\n#{instance_eval(&block)}#{tabs}</#{@mapping[name]}>\n"
    else
      @items << "#{tabs}<#{@mapping[name]}>#{args.first}</#{@mapping[name]}>\n"
    end
  end
end

markup = MissingMarkup.new

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
