PDFKit.configure do |config|
	if RUBY_PLATFORM =~ /64-linux/
    	wkhtmltopdf_executable = 'wkhtmltopdf-amd64'
    	puts "USING 64bit Linux wkhtmltopdf engine"
	elsif RUBY_PLATFORM =~ /i686-linux/
    	wkhtmltopdf_executable = 'wkhtmltopdf-i386'
    	puts "USING 32bit Linux wkhtmltopdf engine"
  elsif RUBY_PLATFORM =~ /darwin/
    wkhtmltopdf_executable = 'wkhtmltopdf-osx'
    puts "USING OSX wkhtmltopdf engine"
  else
    raise "Unsupported. Must be running Linux or intel-based Mac OS."
  end

  config.wkhtmltopdf = Rails.root.join('vendor', 'bin', wkhtmltopdf_executable).to_s
  # config.default_options = {
  #   :page_size => 'Legal',
  #   :print_media_type => true
  # }
end