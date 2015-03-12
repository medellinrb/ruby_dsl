class FancyMarkup

  INDENT = "  "
  TAGS_MAP = {list: "ul",
              div: "div",
              item: "il",
              body: "body"}

  def initialize
    @result = ""
    @depth = 0
  end

  def document(&block)
    @result << "<html> \n"
    instance_eval(&block)
    @result << "</html> \n"
  end

  def process_options(params)
    params.empty? ? "" : params.map{ |k,v| "#{k}='#{v}'" }.join(" ") 
  end
  
  TAGS_MAP.keys.each do |func_tag|
    define_method "#{func_tag}" do |args=nil, &block|
      @depth += 1
      current_depth = @depth

      if args.is_a? Hash
        options = process_options(args)
      else
        html_content = args
      end
      
      if options
        @result << "#{INDENT*current_depth}<#{TAGS_MAP[func_tag]} " + options + "> \n"
      else
        @result << "#{INDENT*current_depth}<#{TAGS_MAP[func_tag]}> \n"
      end

      if html_content
        @result << "#{INDENT*current_depth} #{html_content} \n"
      end
      
      instance_eval(&block) if block
      @result << "#{INDENT*current_depth}<#{TAGS_MAP[func_tag]}/> \n"
    end
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
