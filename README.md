# Domain-Specific Language’s in Ruby
Resources for Ruby DSL talk

## Slides


## Code Kata
Our goal is to create an HTML Markup DSL based on todays talk, (you can take router example as reference)

```ruby
markup = FancyMarkup.new

markup.document do
  body do
    div id: 'container', class: 'kool' do
      list class: 'pretty' do
        item "item 1"
        item "item 2"
      end
    end
  end
end

markup.to_html
#=>
"<html>
  <body>
    <div id="container", class= "kool">
      <ul class="pretty">
        <li>item 1</li>
        <li>item 2</li>
      </ul>
    </div>
  </body>
</html>"
```

Fork and submit your solutions via Github Pull Request
