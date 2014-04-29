class Match < ActiveRecord::Base
	belongs_to :tournament_stage
	has_many :statistics
	has_and_belongs_to_many :teams

	belongs_to :winner, class_name: "Team"

	# status:integer
	before_save { self.status ||= 0 }

	# tournament_stage:references
	validates_presence_of :tournament_stage

	# winner:references
	# not validated

	##
	# Returns whether or not all the statistics have been collected
	# such that the match may be considered finished.
	def finished?
		ok = true
		tournament_stage.scoring.stats_needed.each do |stat|
			ok &= !statistics.where(match: self, name: stat).nil?
		end
		ok
	end

	##
	# Returns all players involved in this match (from all teams).
	def users
		ret = []
		self.teams.each{|t| ret.concat(t.users)}
		return ret
	end

	##
	# Given a sampling class (a class that implements the interface
	# described in `/lib/sampling/README.md`), this returns which
	# statistics (in an Array of Strings) an instance of the class
	# should collect.
	def stats_from(sampling_class)
		figure_sampling_methods.map{|stat,klass| (sampling_class==klass) ? stat : nil}.select{|s| not s.nil?}
	end

	##
	# Delagates PUT/PATCH HTTP params to the appropriate sampling
	# methods.
	def handle_sampling(user, params)
		method_classes.each do |klass|
			klass.new(self).handle_user_interaction(user, params)
		end
	end

	##
	# Delagates out rendering forms to the appropriate sampling
	# methods.
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

	##
	# Calls `Sampling#start` on every sampling method that this match
	# uses.
	def start_sampling
		method_classes.each do |klass|
			klass.new(self).start
		end
	end

	private
	def figure_sampling_methods
		if @sampling_methods.nil?
			data = {}
			needed = self.tournament_stage.scoring.stats_needed
			methods_names = self.tournament_stage.tournament.sampling_methods
			methods_names.each do |method_name|
				method_class = "Sampling::#{method_name.camelcase}".constantize
				needed.each do |stat|
					data[stat] ||= {}
					data[stat][method_class] = method_class.can_get?(stat)
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
				data.add(method)
			end
			@method_classes = data
		end
		return @method_classes
	end

end
