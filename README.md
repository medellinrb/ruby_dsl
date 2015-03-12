# Domain-Specific Language’s in Ruby
Resources for Ruby DSL talk

## Slides
<a href="http://www.slideshare.net/orendon/medellinrb-domain-specific-languages-in-ruby-march-2015" target="_blank">Domain Specific Languages in Ruby + Code Kata</a>

### Ruby DSL Fundamtentals
Check
<a href="https://gist.github.com/orendon/15b824349975f1b1dafc" target="_blank">Blocks, Procs and Lambdas</a>

## Live coding demo, Router

Check `router_dsl.rb` files for a Rails-like router DSL

```ruby
Rotator.new.map do
  resources :items
  get "/about_us/" => "pages#about_us"
  post "/products/" => "products#create"
end
```

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
