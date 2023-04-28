require 'logger'

# Stub logger
class MyLogger
  def initialize
    @loggers = {}
    @loggers['stdout'] = Logger.new(STDOUT)
    @loggers['file'] = Logger.new('output.log', 7, 1048576)
    @tags = []
  end

  def with_tags(tags)
    @tags = @tags.concat(tags).uniq
    self
  end

  def info(message)
    out = "#{@tags.join(', ')} | #{message}"
    @loggers.each { |_,logger| logger.info(out) }
  end
end
