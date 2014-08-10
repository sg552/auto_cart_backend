require 'nokogiri'
class HtmlParser
  attr_accessor :page, :details_table, :price_table, :add_to_cart_button
  def initialize html_content
    @page = Nokogiri::HTML(html_content)
    item_descriptions = @page.css('.itemDescription')
    item_descriptions.each_with_index do |item, i|
      return if i == 1
      @details_table = item.ancestors('table').first
      puts "====== details_table : #{details_table}"
      tr = details_table.ancestors('tr').first
      price_element = tr.css('.price').first
      puts "=== price: #{price_element.inspect}"
      @price_table = price_element.ancestors('table').first
      puts "====== price_table : #{price_table}"
      @add_to_cart_button = price_table.css('img[alt="Add to cart"]')
      puts "====== add_to_cart_button : #{add_to_cart_button}"
    end
  end

  def real_price
    result = @price_table.css('.price').first
    puts "result: #{result}"
    return result.text.sub '$', ''
  end
end
