module Jobs
  class UnitOfWork
    module NoMetadata
      class << self
        def _false
          false
        end
        alias enqueued? _false
        alias started? _false
        alias finished? _false
        alias suceeded? _false
        alias failed? _false
      
      
        # Black hole
        def [] key
          nil
        end
      
        def []= key, value
          nil
        end
        
        def save
          false
        end
      end
    end
  
    delegate :enqueued?, :started?, :finished?, :suceeded?, :failed?, :to => :meta
  
    attr_accessor :job_class, :job_action, :args, :at_time
    def initialize(job_class, job_action, args)
      @job_class, @job_action, @args = job_class, job_action, args
    end
  
    # Enqueue uses Jobs.dump_args to specially encode ActiveRecord objects into Resque
    def enqueue
      @meta = nil # set @meta to nil so it may me accessed after enqueueing
      job_class.enqueue(self)
    end
  
    def schedule(at_time)
      @meta = nil # set @meta to nil so it may me accessed after enqueueing
      job_class.enqueue_at(self, at_time).tap do
        meta['scheduled_at'] = at_time
        meta.save
      end
    end
  
    def cancel
      job_class.remove_delayed(self).tap do
        meta['scheduled_at'] = nil
        meta.save
      end
    end
  
    def args
      Jobs.dump_args(@args)
    end
  
    def loaded_args
      Jobs.load_args(@args)
    end
  
    def raw_args
      @args
    end
  
    def perform
      job_class.perform(self)
    end
  
    def meta_id
      job_class.meta_id(self)
    end
  
    def meta
      @meta ||= job_class.get_meta(meta_id) || NoMetadata
    end
  
    def scheduled?
      scheduled_at.present?
    end
  
    def scheduled_at
      meta['scheduled_at']
    end
  end
end  