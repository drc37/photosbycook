require File.dirname(__FILE__) + '/test_helper'
require File.dirname(__FILE__) + '/response_stubs'

describe "Album" do
  before do
    @empty_album = mock('album')
    @empty_album.stub!(:images).and_return([])
  end
  
  it "should have no images" do
    @empty_album.images.should be_empty
  end
end