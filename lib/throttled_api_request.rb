class ThrottledApiRequest < Struct.new(:api_name, :unit_time, :requests_per)
	def before(job)
		loop do
			sleep_for = -1
			ActiveRecord::Base.transaction do
				ApiRequests.create(:api_name => self.api_name)
				recent_requests = ApiRequets.
					where(:api_name => self.api_name).
					where("updated_at > ?", Time.now.utc - self.unit_time).
					order(:updated_at)
				if (recent_requests.count > self.requests_per)
					sleep_for = Time.now.utc - recent_requests[recent_requests.count-self.requests_per].updated_at
					raise ActiveRecord::Rollback
				else
					sleep_for = -1
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
