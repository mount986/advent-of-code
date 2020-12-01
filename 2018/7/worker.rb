class Worker
  attr_accessor :current_step

  def new_step(step)
    @current_step = step
    step.start unless step.nil?
  end

  def work
    unless @current_step.nil?
      @current_step.work
      @current_step = nil if @current_step.complete?
    end
  end

  def ready?
    @current_step.nil?
  end

end