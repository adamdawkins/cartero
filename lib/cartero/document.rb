require 'uri'
require 'open-uri'
require 'net/http'
require 'json'

module Cartero
  class Document
    @@premailer_uri = URI.parse('http://premailer.dialect.ca/api/0.1/documents')
    attr_accessor :original_html, :original_path, :processed

    def initialize path, options = {}
      @original_html = File.read path
      @original_path = path
      @processed = {}
      premailer options
    end   

    def premailer options
      options[:html] = @original_html
      response = Net::HTTP.post_form( @@premailer_uri, options)       
      documents = JSON.parse(response.body)['documents'] 
      premailer_html_url = documents['html']
      premailer_text_url = documents['txt']

      processed_html = open(premailer_html_url).read.gsub('&amp;amp;', '&amp;')
      processed_text = open(premailer_text_url).read.gsub('&amp;amp;', '&amp;').gsub('&amp;', '&')

      @processed[:html] = processed_html
      @processed[:text] = processed_text
    end

    def save_processed_html path
      File.open(File.expand_path(path), 'wb') do |f|
        f.write @processed[:html]
      end
    end

    def save_processed_text path
      File.open(File.expand_path(path), 'wb') do |f|
        f.write @processed[:text]
      end
    end

  end
end
