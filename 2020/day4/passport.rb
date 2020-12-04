class Passport
  attr_reader :birth_year, :issue_year, :expiration_year, :height,
              :hair_color, :eye_color, :passport_id, :county_id

  def initialize(details)
    @birth_year = details[:byr]
    @issue_year = details[:iyr]
    @expiration_year = details[:eyr]
    @height = details[:hgt]
    @hair_color = details[:hcl]
    @eye_color = details[:ecl]
    @passport_id = details[:pid]
    @country_id = details[:cid]
  end

  def self.parse_fields(details)
    fields = details.split(/\s+/)
    field_hash = Hash.new

    fields.each do |field|
      key, value = field.split(':')
      field_hash[key.to_sym] = value
    end

    field_hash
  end

  def valid_birth_year?
    begin
      year = @birth_year.to_i
      return (year >= 1920 and year <= 2002)
    rescue
      return false
    end
  end

  def valid_issue_year?
    begin
      year = @issue_year.to_i
      return (year >= 2010 and year <= 2020)
    rescue
      return false
    end
  end

  def valid_expiration_year?
    begin
      year = @expiration_year.to_i
      return (year >= 2020 and year <= 2030)
    rescue
      return false
    end
  end

  def valid_height?
    begin
      match, value, units = @height.match(/(\d+)(cm|in)/).to_a
      return false unless match
      value = value.to_i
      case units
      when 'in'
        return (value >= 59 and value <= 79)
      when 'cm'
        return (value >= 150 and value <= 193)
      else
        return 'false'
      end
    rescue
      return false
    end
  end

  def valid_hair_color?
    begin
      return @hair_color.match?(/\A#[0-9a-f]{6}\z/)
    rescue
      return false
    end
  end

  def valid_eye_color?
    begin
      return %w(amb blu brn gry grn hzl oth).include?(@eye_color)
    rescue
      return false
    end
  end

  def valid_passport_id?
    begin
      return @passport_id.match?(/\A[0-9]{9}\z/)
    rescue
      return false
    end
  end

  def valid_country_id?
    true
  end

  def present?
    return false if @birth_year.nil?
    return false if @issue_year.nil?
    return false if @expiration_year.nil?
    return false if @height.nil?
    return false if @hair_color.nil?
    return false if @eye_color.nil?
    return false if @passport_id.nil?

    true
  end

  def valid?
    return (present? and
        valid_birth_year? and
        valid_issue_year? and
        valid_expiration_year? and
        valid_height? and
        valid_hair_color? and
        valid_eye_color? and
        valid_passport_id? and
        valid_country_id?)
  end
end