module UnindexedLoggerAspect
  def set_logger(logger)
    @logger = logger.dup.with_tags(%i(do_not_index))
  end

  def log_after(callable)
    @afters ||= []
    @afters.push(callable)
  end

  def log_before(callable)
    @befores ||= []
    @befores.push(callable)
  end

  private

  def run_befores(logger, befores)
    befores.each { |callable| logger.info(callable.call) }
  rescue
    # Bugsnag
  end

  def method_added(name)
    if @intercepting
      @intercepting = false
      @afters = []
      @befores = []
      return
    end

    @intercepting = true

    logger = @logger
    original_method = instance_method(name)
    befores_method = method(:run_befores)
    afters = @afters || []
    befores = @befores || []

    define_method(name) do |*args, &block|
      befores_method.call(logger, befores)
      result = original_method.bind(self).call(*args, &block)
      result
    ensure
      afters.each { |callable| logger.info(callable.call) }
    end

    @intercepting = false
    @afters = []
    @befores = []

    super
  end
end
