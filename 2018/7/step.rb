class Step
  attr_accessor :id
  attr_accessor :prerequisites
  attr_accessor :status

  BASE_TIME = 60

  def initialize(id)
    @id = id
    @prerequisites = Array.new
    @status = :not_started

    @time_remaining = BASE_TIME + (@id.ord - 64)
  end

  def add_prerequisite(step)
    @prerequisites.push step
  end

  def ready?
    @prerequisites.each do |pre|
      return false unless pre.status == :complete
    end

    status == :not_started
  end

  def start
    @status = :started
  end

  def work
    @time_remaining -= 1
    @status = :complete if @time_remaining == 0
  end

  def complete
    @status = :complete
  end

  def complete?
    @status == :complete
  end
end