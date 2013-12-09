# search for value in a CSV file
Then /I should see in the (?i:CSV) the (?:events|calendars|names): (.*)/ do |items|
	# make sure data sent as CSV
	page.response_headers["Content-Type"].should match /csv/

	# parse view into rows and then values
	rows = page.body.split("\n")
	rows.length.should > 0
	csv = rows.map {|row| row.split(",")}

	# find the item in the name or event column
	name_col = []
	csv[1..-1].each {|row| name_col << row[0]}

	items.split(",").each do |item|
		name_col.should include item.strip
	end
end

And /I export (?:it|page|calendar) to (?i:CSV)/ do
	if page.has_link?("Download Events as CSV")
		click_on("Download Events as CSV")
	elsif page.has_link?("Download List of All Calendars as CSV")
		click_on("Download List of All Calendars as CSV")
	else
		throw "No CSV download link found"
	end

end

When /I am on the index page/ do
	visit("/")
end