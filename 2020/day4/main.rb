require_relative 'passport'

passport_details = File.readlines('input.dat', "\n\n")
passports = Array.new

passport_details.each do |details|
  passports.push Passport.new(Passport.parse_fields(details))
end

puts passports.count { |p| p.present? }
puts passports.count { |p| p.valid? }