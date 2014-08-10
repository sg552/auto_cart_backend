# -*- encoding : utf-8 -*-
require 'nokogiri'
class HtmlParser
  attr_accessor :page, :details_table, :price_table, :add_to_cart_button, :notebooks
  def initialize html_content
    @page = Nokogiri::HTML(html_content)
    item_descriptions = @page.css('.itemDescription')
    @notebooks = []
    item_descriptions.each_with_index do |item, i|
      return if i == 1
      notebook = Notebook.new
      @details_table = item.ancestors('table').first
      tr = details_table.ancestors('tr').first
      price_element = tr.css('.price').first
      @price_table = price_element.ancestors('table').first
      @add_to_cart_button = price_table.css('img[alt="Add to cart"]')
      set_attributes @details_table, notebook
      set_real_price @price_table, notebook

      notebooks << notebook
    end
  end

  def set_real_price price_table, notebook
    result = price_table.css('.price').first
    notebook.real_price = result.text.sub '$', ''
  end

  def set_attributes details_table, notebook
    ul_element_of_details = details_table.css('ul.std-bullet-list')
    begin
      notebook.cpu = ul_element_of_details.css('li').first.text
      notebook.screen = ul_element_of_details.css('li')[2].text
      notebook.harddisk = ul_element_of_details.css('li')[5].text

    rescue  Exception => e
      Rails.logger.error e
      Rails.logger.error e.backtrace.join("\n")

      notebook.cpu = ul_element_of_details.css('li').try(:first).text
      notebook.screen = ul_element_of_details.css('li').try(:[], 2).text
      notebook.harddisk = ul_element_of_details.css('li').try(:[], 5).text
    end
  end
end
