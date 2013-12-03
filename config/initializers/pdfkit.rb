# PDFKit.configure do |config|
# 	puts ("WHAT IS MY RUBY PLATFORM? " + RUBY_PLATFORM)
# 	if RUBY_PLATFORM =~ /64-linux/
#     wkhtmltopdf_executable = 'wkhtmltopdf-amd64'
# 	elsif RUBY_PLATFORM =~ /i686-linux/
#     wkhtmltopdf_executable = 'wkhtmltopdf-i386'
#   elsif RUBY_PLATFORM =~ /darwin/
#     wkhtmltopdf_executable = 'wkhtmltopdf-osx'
#   else
#     raise "Unsupported. Must be running linux or intel-based Mac OS."
#   end

#   config.wkhtmltopdf = Rails.root.join('vendor', 'bin', wkhtmltopdf_executable).to_s
#   # config.default_options = {
#   #   :page_size => 'Legal',
#   #   :print_media_type => true
#   # }
# end