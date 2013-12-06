# search for value in a CSV file
Then /I should see in the (?i:CSV) the event "(.*)"/ do |event|
	# parse view into rows and then values
	rows = page.body.split("\n")
	rows.length.should > 1
	csv = rows.map {|row| row.split(",")}

	# find the event in the name column
	name_index = csv[0].index("Name")
	name_col = []
	csv[1..-1].each {|row| name_col << row[name_index]}
	name_col.should.include event
end

And /I export (?:it|page|calendar) to (?i:CSV)/ do
	click_on("Download Events as CSV")
end

And /I export (?:it|page|calendar) to (?i:PDF)/ do
	click_on("Export to PDF")
end

When /I am on the index page/ do
	visit("/")
end