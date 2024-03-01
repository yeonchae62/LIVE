# frozen_string_literal: true

require 'csv'

# Seed the EVG DB with all included games from the CSV file.
evg_csv_text = Rails.root.join('lib/seeds/2024GamesDatabaseGeneralized.csv').read
parsed_csv = CSV.parse(evg_csv_text, headers: true, encoding: 'ISO-8859-1')
parsed_csv&.each do |row|
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
      publication_year: row['Publication Year'],
      developers: row['Developers'],
      publisher: row['Publisher'],
      used_in_class: row['Still being used in classrooms?'],
      downloadable: row['Still accessible/downloadable?'],
      discontinued: row['Discontinued support?'],
      generalized_subject: row['Generalized Subject'],
      subject1: row['Subject1'],
      subject2: row['Subject2'],
      remainder: row['Subject remainder (a++ b++ c)'],
      teaching: row['Teaching (College++ Training++ Work)'],
      college_users: row['Colleges that use the game'],
      cost: row['Cost'],
      game_type: row['Game Type (Story++ Simulation...)'],
      genre: row['Genre: single player++ multiplayer++ other (specify)'],
      tags: row['Tags'],
      game_time: row['Game Time'],
      dimensions: row['2D/3D'],
      sound: row['Sound'],
      platform: row['Platform'],
      spanish: row['Available in Spanish'],
      other_languages: row['Available in other languages'],
      notes: row['Notes']
    }
  )
end

# use rails logger, this is only here for testing in the meantime
# puts "There are now #{Game.count} rows in the games table"
