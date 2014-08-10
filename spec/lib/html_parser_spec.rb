require 'html_parser'
describe HtmlParser do

  before do
    @parser = HtmlParser.new File.read('spec/fixtures/small_result.html')
  end

  it 'should parse html_content' do
    @parser.details_table.to_s.include?('<span class="itemDescription">Lenovo Lynx K3011</span>').
      should == true
    @parser.price_table.to_s.include?('<span class="strikeprice">$640.00</span><br><span class="price">$190.40</span>').
      should == true
    @parser.add_to_cart_button.to_s.include?('img src="//outlet.lenovo.com/SEUILibrary/lenovo-portal/images/icons/buttons/R5/add_to_cart.gif"').
      should == true
  end

  it 'should get real_price' do
    @parser.real_price.should == '190.40'
  end


end
