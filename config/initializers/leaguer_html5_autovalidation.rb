module ActionView
	module Helpers
		module Tags
			class Base
				def initialize_with_html5_validators(object_name, method_name, template_object, options = {})
					initialize_without_html5_validators(object_name, method_name, template_object, options = {})

					if /(Area|Button|Box|Field|Select)$/ =~ self.class.name
						inject_html5_validators(@object._validators[@method_name.to_sym])
						if @method_name.to_s.end_with?("_confirmation")
							orig_method_name = @method_name.to_s.sub(/_confirmation$/,'').to_sym
							if @object._validators[orig_method_name].any?{|v|v.is_a?(ActiveModel::Validations::ConfirmationValidator)}
								inject_html5_validators(@object._validators[orig_method_name])
							end
						end
					end
				end
				alias_method_chain :initialize, :html5_validators

				private

				def inject_html5_validators(validators = [])
					validators.each do |v|
						# XXX: evaluate :if/:unless?
						if (v.options.keys & [:if, :unless]).empty?
							case v
							when ActiveModel::Validations::AbsenceValidator
								# The opposite of required
								# XXX: perhaps disable the input?
							when ActiveModel::Validations::AcceptanceValidator
								# XXX: If in a text-ish input, perhaps create a pattern from :accept?
								@options[:required] = :required
							when ActiveRecord::Validations::AssociatedValidator
								# Can't possibly do anything here
							when ActiveModel::Validations::ConfirmationValidator
								# Do nothing here
							when ActiveModel::Validations::ExclusionValidator
								# XXX: There is no simple way to do this.
							when ActiveModel::Validations::FormatValidator
								# XXX: Does not support :without
								if v.options[:with] and not v.options[:with].is_a?(Proc)
									pattern = v.options[:with].source.sub(/^\\A/,'').sub(/\\[Zz]$/,'')
									pattern = "(|#{pattern})" if (v.options[:allow_nil] or v.options[:allow_blank])
									@options[:pattern] = pattern
								end
							when ActiveModel::Validations::InclusionValidator
								# XXX: There is no simple way to do this.
							when ActiveModel::Validations::LengthValidator
								@options[:minlength] = v.options[:minimum] if v.options[:minimum]
								@options[:maxlength] = v.options[:maximum] if v.options[:maximum]
							when ActiveModel::Validations::NumericalityValidator
								# XXX: Does not support :other_than
								# XXX: Does not correctly handle any of these things being a Proc
								@options[:required] = :required unless v.options[:allow_nil]
								@options[:step] = 1 if v.options[:only_integer]

								if v.options[:greater_than]
									if @options[:step] or v.options[:even] or v.options[:odd]
										@options[:min] = v.options[:greater_than] + 1
									else
										# Floating point limit BS
										@options[:min] = v.options[:greater_than]
									end
								end
								if v.options[:greater_than_or_equal_to]
									@options[:min] = v.options[:greater_than_or_equal_to]
								end

								if v.options[:less_than]
									if @options[:step] or v.options[:even] or v.options[:odd]
										@options[:max] = v.options[:less_than] - 1
									else
										# Floating point limit BS
										@options[:max] = v.options[:less_than]
									end
								end
								if v.options[:less_than_or_equal_to]
									@options[:max] = v.options[:less_than_or_equal_to]
								end
								
								if v.options[:equal_to]
									@options[:min] = @options[:max] = v.options[:equal_to]
								end

								if v.options[:even] and @options[:min]
									@options[:min] = @options[:min] + @options[:min] % 2
									@options[:step] = 2
								end
								if v.options[:odd] and @options[:min]
									@options[:min] = @options[:min] + (@options[:min]+1) % 2
									@options[:step] = 2
								end
							when ActiveModel::Validations::PresenceValidator, ActiveRecord::Validations::PresenceValidator
								@options[:required] = :required
							when ActiveRecord::Validations::UniquenessValidator
								# Can't do this without making network calls
							when ActiveModel::Validations::WithValidator
								# Just here for completeness; can't possibly do anything
							end # case
						end # if
					end # each
				end # def
			end # class Base
		end # module Tags
	end # module Helpers
end # module ActionView
	
