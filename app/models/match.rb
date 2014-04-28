class Match < ActiveRecord::Base
	belongs_to :tournament_stage
	has_many :statistics
	has_and_belongs_to_many :teams

	belongs_to :winner, class_name: "Team"

	def setup()
	end

	def finished?
		ok = true
		tournament_stage.scoring_method.stats_needed.each do |stat|
			ok &= statistics.where(match: self, name: stat).nil?
		end
		ok
	end

	def win?(player)
		winner.players.include? player
	end

	def users
		ret = []
		self.teams.each{|t| ret.concat(t.users)}
		return ret
	end

	def stats_from(sampling_class)
		figure_sampling_methods.map{|stat,klass| (sampling_class==klass) ? stat : nil}.select{|s| not s.nil?}
	end

	def handle_sampling(user, params)
		method_classes.each do |klass|
			klass.new(self).handle_user_interaction(user, params)
		end
	end

	def render_sampling(user)
		require 'set'
		html = ''

		method_classes.each do |klass|
			html += '<div>'
			html += klass.new(self).render_user_interaction(user)
			html += '</div>'
		end

		return html.html_safe
	end

	def finished?
		# TODO
	end

	private
	def figure_sampling_methods
		if @sampling_methods.nil?
			data = {}
			needed = self.tournament_stage.scoring.stats_needed
			methods_names = self.tournament_stage.tournament.sampling_methods
			methods_names.each do |method_name|
				method_class = "Sampling::#{sampling_name.camelcase}".constantize
				if method_class.works_with(self.tournament_stage.tournament.game)
					needed.each do |stat|
						data[stat] ||= {}
						data[stat][method] = method.can_get?(user, stat)
					end
				end
			end

			needed.each do |stat|
				max_val = nil
				max_pri = 0
				data[stat].each do |method,priority|
					if priority > max_pri
						max_val = method
						max_pri = priority
					end
				end
				data[stat] = max_val
			end
			@sampling_methods = data
		end
		return @sampling_methods
	end

	def method_classes
		if @method_classes.nil?
			data = Set.new
			figure_sampling_methods.each do |stat,method|
				data.push(method)
			end
			@method_classes = data
		end
		return @method_classes
	end

end
