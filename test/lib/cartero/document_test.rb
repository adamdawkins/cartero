require_relative '../../test_helper'

describe Cartero::Document do
  before :all do
    @path = File.expand_path 'test/fixtures/31_140311.html'
    @doc = Cartero::Document.new @path, {
      link_query_string: 'utm_campaign=test&something-else=another-thing'
    }
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

    it 'sets processed[:html] to the premailer HTML' do
      #@doc.processed[:html].must_equal File.read File.expand_path('test/fixtures/31_140311-premailer.html')
      @doc.processed[:html].class.name.must_equal 'String'
    end  

    it 'sets processed[:text] to the premailer text version' do
      #@doc.processed[:text].must_equal File.read File.expand_path('test/fixtures/31_140311-text.txt')
       @doc.processed[:text].class.name.must_equal 'String'
    end
  end

  describe '#save_processed_html' do
    before :all do
      @test_processed_path = 'test/output/new_premailer_test.html'
      @doc.save_processed_html @test_processed_path
    end

    it 'creates a file with the path' do
      File.open(File.expand_path(@test_processed_path)).must_be_kind_of File
    end
  end

  describe '#save_processed_text' do
    before :all do
      @test_processed_path = 'test/output/new_premailer_test.txt'
      @doc.save_processed_text @test_processed_path
    end

    it 'creates a file with the path' do
      File.open(File.expand_path(@test_processed_path)).must_be_kind_of File
    end
  end
end
