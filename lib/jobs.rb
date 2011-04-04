# Jobs allow us to pass AR objects directly
# into mailers as we would expect to do. The reason we have to do these
# extensions is that Resque can only enqueue JSON arguments.
# 
# So for these jobs we're doing a fairly naive dump/load for AR objects.
# The dump format is {"class":"ClassName", "id":"4939"}
# FIXME: use of *splat operator got waayyy out of hand in this module. 
#   WTF/LOC too high.
require "resque-meta"
require "resque_scheduler"
require "active_support"

module Jobs
  require "jobs/base"
  require "jobs/unit_of_work"

  

  # Load JSON args, understanding how to load an ActiveRecord object from dump_args
  def self.load_args(args)
    args.map do |arg|
      if arg.is_a?(Hash) && arg.key?("class") && arg.key?("id")
        arg["class"].constantize.find(arg["id"])
      else
        arg
      end
    end
  end
  
  # Dump JSON args, with a special format for ActiveRecord objects to be parsed by load_args
  def self.dump_args(args)
    args.map do |arg|
      if arg.respond_to?(:find) && arg.respond_to?(:to_param)
        {"class" => arg.class.to_s, "id" => arg.to_param}
      else
        arg
      end
    end
  end
end