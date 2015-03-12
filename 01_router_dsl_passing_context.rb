class Rotator
  def initialize
    @routes = []
  end

  def map
    yield self
    puts @routes
  end

  def get(route)
    @routes << {verb: 'GET'}.merge(route)
  end

  def post(route)
    @routes << {verb: 'POST'}.merge(route)
  end
end

Rotator.new.map do |r|
  r.get '/about_us/' => "pages#about_us"
  r.post '/products/' => "products#create"
end
