# frozen_string_literal: true

require 'csv'

# Seed the EVG DB with all included games from the CSV file.
csv_file_path = Rails.root.join('lib/seeds/2024GamesDatabaseGeneralized.csv')
csv_file_content = File.read(csv_file_path, encoding: 'UTF-8')
parsed_csv = CSV.parse(csv_file_content, headers: true)

parsed_csv&.each do |row| # rubocop:disable Metrics/BlockLength
  next unless row['Included'] == 'TRUE'

  Game.create!(
    {
      id: row['ID'],
      game_title: row['Game Title'],
      source: row['Source'],
      researcher: row['Researcher'],
      included: row['Included'],
      exclusion_notes: row['Exclusion Notes'],
      url: row['URL'],
      publication_year: row['Year game was published'],
      developers: row['Developers'],
      publisher: row['Publisher'],
      used_in_class: row['Still being used in classrooms?'],
      downloadable: row['Still accessible/downloadable?'],
      discontinued: row['Discontinued support?'],
      generalized_subject: row['Generalized Subject'],
      subject1: row['Subject1'],
      subject2: row['Subject2'],
      remainder: row['Subject remainder (a, b, c)'],
      teaching: row['Teaching (College, Training, Work)'],
      college_users: row['Colleges that use the game'],
      cost: row['Cost'],
      game_type: row['Game Type (Story, Simulation...)'],
      genre: row['Genre: single player, multiplayer, other (specify)'],
      tags: row['Tags'],
      game_time: row['Game Time'],
      dimensions: row['2D/3D'],
      sound: row['Sound'],
      platform: row['Platform'],
      spanish: row['Available in Spanish'],
      other_languages: row['Available in other languages'],
      notes: row['Notes'],
      image: row['Image1']
    }
  )
end

Game.find_each do |game|
  if game.cost.nil?
    game.update(cost_value: nil)
  elsif game.cost.downcase.include?('free')
    game.update(cost_value: 0.0)
  else
    numeric_value = game.cost.scan(/(\d+\.\d+|\d+)/).first
    game.update(cost_value: numeric_value ? numeric_value.first.to_f : nil)
  end
end

users = [
  { email: 'user@example.com', password: 'user@example.com', role: 0 },
  { email: 'moderator@example.com', password: 'moderator@example.com', role: 1 },
  { email: 'admin@example.com', password: 'admin@example.com', role: 2 }
]

users.each do |user_attrs|
  User.create!(user_attrs)
end

# use rails logger, this is only here for testing in the meantime
# puts "There are now #{Game.count} rows in the games table"
