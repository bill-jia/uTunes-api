# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Album.create([
	{title: "Twig Tape XXIX", year: 2014},
	{title: "Twig Tape XXVIII", year: 2013},
	{title: "Twig Tape XXVII", year: 2012},
	{title: "Twig Tape XXVI", year: 2011}
])

a5 = Album.create(year: 2015, title: "Potato")
t1 = Track.create(title: "Spud", track_number: 1, length_in_seconds: 240)
a5.tracks << [t1]