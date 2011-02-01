module HasSchedule
	def self.included(base)
		base.send :extend, ClassMethods
	end

	module ClassMethods
		def has_schedule
			send :include, InstanceMethods

			attr_writer :schedule

			alias_method_chain :reload, :schedule
			before_save :save_with_schedule
		end
	end

	module InstanceMethods
		def reload_with_schedule
			@schedule = nil
			reload_without_schedule
		end
		
		def save_with_schedule
			self.schedule_yaml = @schedule.to_yaml unless @schedule.nil?
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
