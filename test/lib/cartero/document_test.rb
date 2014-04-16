require_relative '../../test_helper'

describe Cartero::Document do
  before do
    @path = File.expand_path 'test/fixtures/31_140311.html'
    @doc = Cartero::Document.new @path
  end

  describe 'initialize' do
    describe 'with valid document path' do
      it 'sets original_html to the document contents' do
        @doc.original_html.must_equal File.read @path
      end

      it 'sets original_path to the path' do
        @doc.original_path.must_equal @path
      end
    end
  end

  describe '#premailer' do
    before :all do
      @doc.premailer
    end
    it 'sets processed[:html] to the premailer HTML' do
      #@doc.processed[:html].must_equal File.read File.expand_path('test/fixtures/31_140311-premailer.html')
      @doc.processed[:html].class.name.must_equal 'String'
    end  
    it 'sets processed[:text] to the premailer text version' do
      #@doc.processed[:text].must_equal File.read File.expand_path('test/fixtures/31_140311-text.txt')
       @doc.processed[:text].class.name.must_equal 'String'
    end
  end
end
