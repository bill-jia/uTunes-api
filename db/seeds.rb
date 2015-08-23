# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

a1 = Album.create(title: "Twig Tape XXIX", year: 2014)
a2 = Album.create(title: "Twig Tape XXVIII", year: 2013)
a3 = Album.create(title: "Twig Tape XXVII", year: 2012)
a4 = Album.create(title: "Twig Tape XXVI", year: 2011)
a5 = Album.create(year: 2015, title: "Potato")

t1 = Track.create(title: "Spud", track_number: 1, length_in_seconds: 240)
t2 = Track.create(title: "Creamed Corn", track_number: 1, length_in_seconds: 420)
a5.tracks << [t1]
a1.tracks << [t2]

r1 = Artist.create(name: "ABCD", class_year: 2015, bio: "Lorem ipsum")
