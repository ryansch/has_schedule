module HasSchedule
	def self.included(base)
		base.send :extend, ClassMethods
	end

	module ClassMethods
		def has_schedule
			send :include, InstanceMethods

			alias_method_chain :reload, :schedule
			before_save :save_with_schedule
		end
	end

	module InstanceMethods
		def reload_with_schedule
			@schedule = nil
			@nil_requested = nil
			reload_without_schedule
		end
		
		def save_with_schedule
			if (@schedule.nil? and @nil_requested != nil) or @schedule != nil
				self.schedule_yaml = @schedule.andand.to_yaml
			end
		end

		def schedule=(schedule)
			@schedule = schedule

			if @schedule.nil?
				@nil_requested = true
				save_with_schedule
			else
				@nil_requested = nil
			end
		end

		def schedule
			@schedule ||= if self.schedule_yaml.blank? 
											nil
										else
											IceCube::Schedule.from_yaml(self.schedule_yaml)
										end
		end
	end
end

ActiveRecord::Base.send :include, HasSchedule
