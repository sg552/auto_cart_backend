require 'spec_helper'
describe NotebookFiltersController do
  it 'should post read_complete_content' do
    filter = NotebookFilter.create :cpu => '2760', :screen => '1366', :price => '100-200'
    filter = NotebookFilter.create :cpu => '2760', :screen => 'ips', :price => '100-300'
    post :read_complete_content, :html_content => File.read('spec/fixtures/small_result.html')
    response.body.include?('success').should == true
  end
  it 'should post read_complete_content' do
    filter = NotebookFilter.create :cpu => '2760', :screen => '1366', :price => '100-200'
    filter = NotebookFilter.create :cpu => '2760', :screen => 'ips', :price => '100-300'
    post :read_complete_content, :html_content => File.read('spec/fixtures/big_content.html')
    response.body.include?('success').should == true
  end
end
