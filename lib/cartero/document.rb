require 'uri'
require 'open-uri'
require 'net/http'
require 'json'

module Cartero
  class Document
    @@premailer_uri = URI.parse('http://premailer.dialect.ca/api/0.1/documents')
    attr_accessor :original_html, :original_path, :processed

    def initialize path
      @original_html = File.read path
      @original_path = path
      @processed = {}
      # premailer
    end   

    def premailer
      response = Net::HTTP.post_form(
        @@premailer_uri,
        {html: @original_html}
      )       
      documents = JSON.parse(response.body)['documents'] 
      premailer_html_url = documents['html']
      premailer_text_url = documents['txt']

      @processed[:html] = open(premailer_html_url).read
      @processed[:text] = open(premailer_text_url).read
    end

    def save_processed_html path
      if @processed[:html] == nil
        premailer
      end
      
      File.open(File.expand_path(path), 'wb') do |f|
        f.write @processed[:html]
      end
    end

    def save_processed_text path
      if @processed[:text] == nil
        premailer
      end
      
      File.open(File.expand_path(path), 'wb') do |f|
        f.write @processed[:text]
      end
    end

  end
end
