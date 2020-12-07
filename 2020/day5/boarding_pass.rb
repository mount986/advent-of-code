class BoardingPass
  attr_reader :row, :seat, :id

  def initialize(pass)
    row = pass[0, 7]
    seat = pass[7, 3]

    row = row.gsub('B', '1') || row
    row  = row.gsub('F', '0') || row
    seat = seat.gsub('R', '1') || seat
    seat = seat.gsub('L', '0') || seat

    @row = row.to_i(2).to_s(10).to_i
    @seat = seat.to_i(2).to_s(10).to_i
    @id = (8 * @row) + @seat
  end
end