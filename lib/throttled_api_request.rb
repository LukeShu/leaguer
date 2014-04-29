# limits is in the format:
#     limits = [
#       {:unit_time => 10.seconds, :requests_per => 10},
#       {:unit_time => 10.minutes, :requests_per => 500},
#     ]
class ThrottledApiRequest < Struct.new(:api_name, :limits)
	def before(job)
		loop do
			sleep_for = -1
			ActiveRecord::Base.transaction do
				ApiRequests.create(:api_name => self.api_name)
				self.limits.each do |limit|
					recent_requests = ApiRequets.
						where(:api_name => self.api_name).
						where("updated_at > ?", Time.now.utc - limit[:unit_time]).
						order(:updated_at)
					if (recent_requests.count > limit[:requests_per])
						sleep_for = [sleep_for, Time.now.utc - recent_requests[recent_requests.count-limit[:requests_per]].updated_at].max
					end
				end
				if sleep_for != -1
					raise ActiveRecord::Rollback
				end
			end
			if sleep_for != -1
				sleep(sleep_for)
			else
				break
			end
		end
	end
end
