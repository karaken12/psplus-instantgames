#!/usr/bin/env ruby

def cat(fname)
  file = File.new(fname, 'r')
  while (line = file.gets)
    puts line
  end
  file.close
end

def puts_game(name, number)
  puts '|-'
  puts "| #{number}"
  puts "| #{name}"
end

def puts_update_rows(update, rowspan)
  puts "| rowspan=\"#{rowspan}\"| {{dts|format=dmy|#{update.start_date}}}"
  if update.end_date
    puts "| rowspan=\"#{rowspan}\"| {{dts|format=dmy|#{update.end_date}}}"
  else
    puts "| rowspan=\"#{rowspan}\"|"
  end
  if !update.ref_created
    puts "| rowspan=\"#{rowspan}\" style=\"text-align:center;\"| <ref name=\"#{update.ref_name}\">{{cite web|url=#{update.url}|title=#{update.title}|publisher=[[PlayStation Blog]]|date=#{update.blog_date}|accessdate=#{update.access_date}}}</ref>"
    update.ref_created = true
  else
    puts "| rowspan=\"#{rowspan}\" style=\"text-align:center;\"| <ref name=\"#{update.ref_name}\"/>"
  end
end

def puts_game_2(game, number, first = false, update = nil, rowspan = nil)
  if !game.alternates
    puts '|-'
    puts "| #{number}"
    puts "| #{game.name}"
    if first
      puts_update_rows(update, rowspan)
    end
  else
    puts '|-'
    puts "| rowspan=\"#{game.alternates.length + 1}\"| #{number}"
    puts "| #{game.name}"
    if first
      puts_update_rows(update, rowspan)
    end
    game.alternates.each do |alternate|
      puts '|-'
      puts "| #{alternate.name}"
    end
  end
end

def puts_update(update, max_number)
  rowspan = update.games.length
  update.games.each {|game| if game.alternates then rowspan += game.alternates.length end}
  update.games.each do |game|
    max_number += 1
    if game == update.games[0]
      puts_game_2(game, max_number, true, update, rowspan)
    else
      puts_game_2(game, max_number)
    end
  end
end

class Game
  attr_accessor :name, :alternates

  def initialize(name)
    @name = name
  end
end

class PlusUpdate
  attr_accessor :start_date, :title, :blog_date, :access_date, :url, :ref_name, :games, :end_date, :ref_created
end

cat('intro.txt')
puts
cat('ps3.txt')

update = PlusUpdate.new
update.start_date = '2015-08-04'
update.end_date = '2015-09-01'
update.url = "http://blog.eu.playstation.com/2015/07/29/playstation-plus-in-august-lara-croft-god-of-war-stealth-inc-2-more/"
update.title = "PlayStation Plus in August: Lara Croft, God of War, Stealth Inc 2, more"
update.blog_date = '29 July 2015'
update.access_date = '30 July 2015'
update.ref_name = 'August15'
update.games = [ Game.new("''[[God of War: Ascension|God of War Ascension]]''") ]
update.games[0].alternates = [ Game.new("''Flow'' <small>(cross-buy)</small> <small>(Bahrain, Kuwait, Lebanon, Oman, Qatar, Saudi Arabia, UAE)</small>") ]
update.games.push Game.new("''[[Stealth Inc. 2: A Game of Clones|Stealth Inc 2: A Game of Clones]]'' <small>(cross-buy)</small>")
game = Game.new("''[[Sound Shapes]]'' <small>(cross-buy)</small>")
game.alternates = [ Game.new("''[[Flower (video game)|Flower]]'' <small>(cross-buy)</small> <small>(Saudi Arabia, Kuwait, Qatar, UAE, India and Turkey)</small>") ]
update.games.push game
update.games.push Game.new("''[[CastleStorm|CastleStorm Complete Edition]]'' <small>(cross-buy)</small>")
august15_update = update

puts_update(update, 172)

max_number = 176

update = PlusUpdate.new
update.start_date = '2015-09-01'
update.title = 'PlayStation Plus in September: Grow Home, Super Time Force Ultra, Twisted Metal'
update.blog_date = '24 August 2015'
update.access_date = '1 September 2015'
update.url = "http://blog.eu.playstation.com/2015/08/24/playstation-plus-in-september-grow-home-super-time-force-ultra-twisted-metal/"
update.ref_name = 'September15'
update.games = [ Game.new('Twisted Metal'), Game.new('Teslagrad') ]

puts_update(update, max_number)

puts '|}'
puts

cat 'ps4.txt'

update = august15_update
update.games = []
update.games.push Game.new("''[[Lara Croft and the Temple of Osiris]]''")
update.games.push Game.new("''[[Limbo (video game)|Limbo]]''")
update.games.push Game.new("''[[Stealth Inc. 2: A Game of Clones|Stealth Inc 2: A Game of Clones]]'' <small>(cross-buy)</small>")
game = Game.new("''[[Sound Shapes]]'' <small>(cross-buy)</small>")
game.alternates = [ Game.new("''[[Flower (video game)|Flower]]'' <small>(cross-buy)</small> <small>(Saudi Arabia, Kuwait, Qatar, UAE, India and Turkey)</small>") ]
update.games.push game

puts_update(update, 50)

puts '|}'
puts

cat 'vita.txt'
update = august15_update
update.games = []
update.games.push Game.new("''[[Stealth Inc. 2: A Game of Clones|Stealth Inc 2: A Game of Clones]]'' <small>(cross-buy)</small>")
game = Game.new("''[[Sound Shapes]]'' <small>(cross-buy)</small>")
game.alternates = [ Game.new("''[[Flower (video game)|Flower]]'' <small>(cross-buy)</small> <small>(Saudi Arabia, Kuwait, Qatar, UAE, India and Turkey)</small>") ]
update.games.push game
update.games.push Game.new("''[[CastleStorm|CastleStorm Complete Edition]]'' <small>(cross-buy)</small>")

puts_update(update, 86)

puts '|}'
puts

cat 'other.txt'
puts
cat 'outro.txt'
