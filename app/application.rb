class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

# wrote out the new routes /cart/ and /add/ separately, then integrated them into the if-elsif stmt below
    # if req.path.match(/cart/)
    #   if @@cart.empty?
    #     resp.write "Your cart is empty"
    #   else
    #     @@cart.each do |cart_item|
    #       resp.write "#{cart_item}\n"
    #     end
    #   end #end if @@cart.empty? stmt
    #   resp.finish
    # end #end req.path.match(/cart/) stmt

    # if req.path.match(/add/)
    #   search_item = req.params["item"]
    #   if @@items.include?(search_item)
    #     @@cart << search_item
    #     resp.write "added #{search_item}"
    #   else
    #     resp.write "We don't have that item"
    #   end #end if @@items.include?(search_item) stmt
    # end #end req.path.match(/add/) stmt

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty"
      else
        @@cart.each do |cart_item|
          resp.write "#{cart_item}\n"
        end
      end #end if @@cart.empty? stmt
    elsif req.path.match(/add/)
      search_item = req.params["item"]
      if @@items.include?(search_item)
        @@cart << search_item
        resp.write "added #{search_item}"
      else
        resp.write "We don't have that item"
      end #end if @@items.include?(search_item) stmt
    else
      resp.write "Path Not Found"
    end #end if-elsif stmt

    resp.finish
  end #end call method

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end #end handle_search
end #end Application class
