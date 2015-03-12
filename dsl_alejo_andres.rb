class FancyMarkup
  def initialize
    @result = ""
    @depth = 0
    @indent = "  "
  end

  def document(&block)
    @depth += 1
    @result += "<html> \n"
    instance_eval(&block)
    @result += "</html> \n"
  end

  def body
    my_depth = @depth
    @depth += 1
    @result += "#{@indent*@depth}<body> \n"
    yield
    @result += "#{@indent*my_depth}</body> \n"
  end
  
  [:div, :list].each do |tag|
    define_method "#{tag}" do |params, &block| 
      tags_map = {:list => "ul",
                  :div => "div"}
      my_depth = @depth
      @depth += 1
      my_options = params.map{ |k,v| "#{k}='#{v}'" }.join(" ")
      @result += "#{@indent*@depth}<#{tags_map[tag]} "  + my_options + ">\n"
      block.call
      @result += "#{@indent*my_depth}<#{tags_map[tag]}/> \n"
    end
  end

  def item(html=nil)
    my_depth = @depth
    @result += "#{@indent*@depth}<li> \n"
    block_given? ? yield : @result += "#{@indent*my_depth} #{html} \n" || ""
    @result += "#{@indent*my_depth}</li> \n"
  end
  
  def to_html
    puts @result
  end
end

markup = FancyMarkup.new

markup.document do
  body do
    div id: "container" do
      list class: "pretty" do
        item "item 1"
        item do
          div id: "cont2" do
          end
        end
      end
    end
  end
end

markup.to_html
