class HtmlParser
  def self.parse html_content
    page = Nokogiri::HTML(html_content)
    item_descriptions = page.css('.itemDescription')
    item_descriptions.each_with_index do |item, i|
      return if i == 1

      puts "-- parent_table: #{i}"
      details_table = item.ancestors('table').first
      puts "====== details_table : #{details_table}"
      tr = details_table.ancestors('tr').first
      price_element = tr.css('.price').first
      puts "=== price: #{price_element.inspect}"
      price_table = price_element.ancestors('table').first
      puts "====== price_table : #{price_table}"
      add_to_cart_button = price_table.css('img[alt="Add to cart"]')
      puts "====== add_to_cart_button : #{add_to_cart_button}"


    end
  end

  def self.get_price single_notebook_tr_dom
    single_notebook_tr_dom.css('.price')
  end
end
