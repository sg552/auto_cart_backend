# -*- encoding : utf-8 -*-
require 'nokogiri'
class HtmlParser
  attr_accessor :page, :details_table, :price_table, :add_to_cart_button, :notebooks,
    :parser_id

  def initialize html_content, options = {}

    @parser_id = Time.now.to_s
    @page = get_content_with_pure_html html_content
    item_descriptions = @page.css('.itemDescription')
    @notebooks = []
    puts "item_descriptions: #{item_descriptions.size}"
    item_descriptions.each_with_index do |item, i|
      return if options[:max_item].present? && i == options[:max_item]
      notebook = Notebook.new :created_by => @parser_id
      @details_table = item.xpath('./ancestor::table[1]')
      #@details_table = item.ancestors('table').first
      tr = details_table.xpath('./ancestor::tr[1]')
      #tr = details_table.ancestors('tr').first
      set_attributes @details_table, notebook

      price_element = tr.css('.price').first
      @price_table = price_element.xpath('./ancestor::table[1]')
      set_real_price @price_table, notebook

      @add_to_cart_button = price_table.css('img[alt="Add to cart"]')
      set_add_to_cart_url @add_to_cart_button, notebook
      @notebooks << notebook
    end
    Notebook.import @notebooks
  end

  # 核心方法, 用法见rspec
  def get_urls filters
    result = []
    filters.each do |filter|
      notebooks = Notebook.where('created_by = ?', @parser_id )
      notebooks = notebooks.where('cpu like ? ', "%#{filter.cpu}%") if filter.cpu.present?
      notebooks = notebooks.where('harddisk like ? ', "%#{filter.harddisk}%") if filter.harddisk.present?
      notebooks = notebooks.where('screen like ? ', "%#{filter.screen}%") if filter.screen.present?
      if filter.price.present?
        lower_price, higher_price = filter.price.split('-')
        notebooks = notebooks.where('real_price <= ? and real_price >= ? ',
                                    higher_price, lower_price )
      end
      result += notebooks.map(&:add_to_cart_link)
    end
    result.uniq
  end

  private

  def get_content_with_pure_html html_content
    temp_html = Nokogiri::HTML(html_content)
    temp_html.css('script').remove
    temp_html.css('style').remove
    temp_html
  end
  def set_add_to_cart_url add_to_cart_button, notebook
    onclick_link = add_to_cart_button.first["onclick"]
    result = 'http:' + onclick_link.match(/'.*'/)[0].to_s.gsub("'", '')
    notebook.add_to_cart_link = result
  end

  def set_real_price price_table, notebook
    result = price_table.css('.price').first
    notebook.real_price = result.text.sub '$', ''
  end

  def set_attributes details_table, notebook
    logger.info "===  set_attributes: "
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
  def logger
    Rails.logger
  end
end
