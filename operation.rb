require_relative 'logging.rb'
require_relative 'unindexed_logger_aspect.rb'

class Operation
  extend UnindexedLoggerAspect

  # There are some nuances here. We can figure out how to get the Logger Aspect to assign the class
  # It infers the `do_not_index` tag
  LOGGER = MyLogger.new.with_tags(%i(operation))
  set_logger(MyLogger.new.with_tags(%i(operation)))
  private_constant :LOGGER
  
  def unobserved_method(str: "bye")
    puts str
    str
  end

  log_before lambda { { state: "Before State" } }
  log_after lambda { {state: 'After State'} }
  def observed_method(str: "hi")
    _logger.info(str)
    puts str
    str
  end

  def more_unobserved_method(str: "byebye")
    _logger.info(str)
    puts str
    str
  end

  private

  def _logger
    LOGGER
  end
end
