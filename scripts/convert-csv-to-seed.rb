require 'csv'
require 'securerandom'
require 'iso_country_codes'
require 'json'

def parse_personal_profile(row, first_name, middle_name, last_name)
  bday = row["DoB"].split(' ')[0]
  preferred_foot = row["Preferred Foot"].split(' ')[0]
  preferred_foot = 'Both' if preferred_foot == 'Either'
  height = row["Height"].split(' ')[0]
  weight = row["Weight"].split(' ')[0]
  begin
    country_code = IsoCountryCodes.find(row["Nat"]).alpha2
  rescue => error
    puts "Can't find country for code: #{row['Nat']}"
    country_code = nil
  end
  playing_positions = playing_position_for(row["Position"])
  "personal_profile = PersonalProfile.create(user_id: user.id, first_name: '#{first_name}', middle_name: '#{middle_name}', last_name: '#{last_name}', birthday: '#{bday}', nationality_country_code: '#{country_code}', height: '#{height}', weight: '#{weight}', playing_positions: '#{playing_positions}', preferred_foot: '#{preferred_foot}')"
end

def position_for(area, side)
  final_area = case area
               when "M"
                 "Midfielder"
               when "D"
                 "Defender"
               when "WB"
                 "Wing-back"
               when "AM"
                 "Attacking Midfielder"
               when "ST"
                 "Striker"
               end
  final_side =  case side
                when "R"
                  "Right"
                when "L"
                  "Left"
                when "C"
                  "Center"
                end

  final_pos = "#{final_area} (#{final_side})"
  if final_pos == "Attacking Midfielder (Left)"
    final_pos = "Winger (Left)"
  elsif final_pos == "Attacking Midfielder (Right)"
    final_pos = "Winger (Right)"
  end
  # - Sweeper (Centre)
  # - Defender (Right)
  # - Defender (Left)
  # - Defender (Centre)
  # - Wing-back (Right)
  # - Wing-back (Left)
  # - Defensive Midfielder (Centre)
  # - Midfielder (Right)
  # - Midfielder (Left)
  # - Midfielder (Centre)
  # - Attacking Midfielder (Centre)
  # - Winger (Right)
  # - Winger (Left)
  # - Second Striker (Centre)
  # - Striker (Centre)
  { skill: 0, position: final_pos }
end

def playing_position_for(pos)
  final_pos = []
  positions = pos.split(', ')
  positions.each do |position|
    areas, sides = position.split(" ")
    all_areas = areas.split("/")
    all_sides = if sides
                  sides.delete("()").split("")
                else
                  []
                end
    all_areas.each do |area|
      if area == "DM"
        final_pos << { skill: 0, position: "Defensive Midfielder (Centre)"}
      elsif area == "GK"
        final_pos << { skill: 0, position: "Goalkeeper"}
      else
        all_sides.each do |side|
          parsed_pos = position_for(area, side)
          final_pos << parsed_pos
        end
      end
    end
  end
  puts final_pos
  final_pos.to_json
end

CSV.foreach('tmp/gib-player-ethan-robert.csv', headers: true) do |row|
  name_parts = row["Name"].split(' ')
  first_name = name_parts.shift
  last_name = name_parts.pop
  middle_name = name_parts.join(' ')
  email = "#{first_name}_#{last_name}_new@firsttouch.io"
  pwd = SecureRandom.hex
  puts "user = User.create(email: '#{email}', password: '#{pwd}', password_confirmation: '#{pwd}', unclaimed: true)"
  puts parse_personal_profile(row, first_name, middle_name, last_name)
end
