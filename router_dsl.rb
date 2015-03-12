class Rotator
  def initialize
    @routes = []
  end

  def map(&block)
    instance_eval(&block)
    puts @routes
  end

  def resources(name)
    get "/#{name.to_s}" => "#{name.to_s}#index"
    post "/#{name.to_s}" => "#{name.to_s}#create"
    get "/#{name.to_s}/new" => "#{name.to_s}#new"
  end

  def get(route)
    @routes << {verb: 'GET'}.merge(route)
  end

  def post(route)
    @routes << {verb: 'POST'}.merge(route)
  end
end

Rotator.new.map do
  resources :items
  get '/about_us/' => "pages#about_us"
  post '/products/' => "products#create"
end
