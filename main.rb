require_relative 'operation.rb'

Operation.new.unobserved_method
# This method should emit logs before and after
Operation.new.observed_method
Operation.new.more_unobserved_method
