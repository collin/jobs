module Jobs
  class Base
    extend Resque::Plugins::Meta
  
    class << self
      def queue_name
        name.underscore
      end
      
      alias queue queue_name
    end
  
    # Set @queue because resque expects every worker class to provide one.
    def self.inherited(subclass)
      subclass.instance_variable_set :@queue, subclass.queue_name
    end
  
    def self.method_missing(name, *args)
      if public_instance_methods.include?(name)
        Jobs::UnitOfWork.new(self, name, args)
      else
        super
      end
    end
  
    # peform user Jobs.load_args to decode hashes representing ActiveRecord objects in Resque
    def self.perform(meta_id, job_action, *args)
      perform_unit_of_work Jobs::UnitOfWork.new(self, job_action, args)
    end
    
    def self.perform_unit_of_work(unit_of_work)
      new.send *unit_of_work.loaded_args.unshift(unit_of_work.meta).unshift(unit_of_work.job_action)      
    end
  
    # Override in your job to control the metadata id. It is
    # passed the same arguments as `perform`, that is, your job's
    # payload.
    def self.meta_id(unit_of_work)
      Digest::SHA1.hexdigest([ Time.now.to_f, rand, self, unit_of_work.args ].join)
    end
  
    # Enqueues a job in Resque and return the association metadata.
    # The meta_id in the returned object can be used to fetch the
    # metadata again in the future.
    def self.enqueue(unit_of_work)
      meta = Resque::Plugins::Meta::Metadata.new({'meta_id' => meta_id(unit_of_work), 'job_class' => self.to_s})
      meta.save
      Resque.enqueue(self, meta.meta_id, unit_of_work.job_action, *unit_of_work.args)    
      meta
    end

    # Schedules a delayed job in Resque and return the association metadata.
    # The meta_id in the returned object can be used to fetch the
    # metadata again in the future.  
    def self.enqueue_at(unit_of_work, at_time)
      meta = Resque::Plugins::Meta::Metadata.new({'meta_id' => meta_id(unit_of_work), 'job_class' => self.to_s})
      meta.save
      Resque.enqueue_at(at_time, self, unit_of_work.job_action, *unit_of_work.args)
      meta
    end

    # Unschedules a delayed job for a unit of work.
    def self.remove_delayed(unit_of_work)
      Resque.remove_delayed(self, unit_of_work.job_action, *unit_of_work.args)
    end

    # Work on chron schtuffs
    # # Compatibility
    # def self.schedule
    #   
    # end
  end
end