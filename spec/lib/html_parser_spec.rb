require 'html_parser'
describe HtmlParser do

  before do
    @parser = HtmlParser.new File.read('spec/fixtures/small_result.html')
    @notebook = @parser.notebooks.first
  end

  it 'should get details_table' do
    @parser.details_table.to_s.include?('<span class="itemDescription">Lenovo Lynx K3011</span>').
      should == true
  end
  it 'should get price_table' do
    @parser.price_table.to_s.include?('<span class="strikeprice">$640.00</span><br><span class="price">$190.40</span>').
      should == true
  end

  it 'should get add_to_cart_button' do
    @parser.add_to_cart_button.to_s.include?('img src="//outlet.lenovo.com/SEUILibrary/lenovo-portal/images/icons/buttons/R5/add_to_cart.gif"').
      should == true
  end

  it 'should get real_price' do
    @notebook.real_price.should == '190.40'
  end

  it 'should set_attributes' do
    @parser.set_attributes(@parser.details_table, @notebook)
  end

  it 'should set_add_to_cart_url' do
    @parser.set_add_to_cart_url @parser.add_to_cart_button, @notebook
    @notebook.add_to_cart_link.should == 'http://outlet.lenovo.com/SEUILibrary/controller/e/outlet_us/LenovoPortal/en_US/config.workflow:ConfigureMtmAsItem?mtm-item=:000001BD:0000F467:&action=addtocart'
  end
end
