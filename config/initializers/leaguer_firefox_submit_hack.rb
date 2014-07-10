# -*- ruby-indent-level: 2; indent-tabs-mode: nil -*-
# This hacks around <input type="submit"> being sized weird by replacing it with <button type="submit">
# This was nescessary in FF28, no longer in FF30.
# I have no idea about Chrome or Safari; I imagine browsers are converging on making it sized sanely.
module ActionView
  module Helpers
    module FormTagHelper

      # This is modified from actionpack-4.0.2/lib/action_view/helpers/form_tag_helper.rb#submit_tag
      def submit_tag(value = "Save changes", options = {})
        options = options.stringify_keys

        if disable_with = options.delete("disable_with")
          message = ":disable_with option is deprecated and will be removed from Rails 4.1. " \
                    "Use 'data: { disable_with: \'Text\' }' instead."
          ActiveSupport::Deprecation.warn message

          options["data-disable-with"] = disable_with
        end

        if confirm = options.delete("confirm")
          message = ":confirm option is deprecated and will be removed from Rails 4.1. " \
                    "Use 'data: { confirm: \'Text\' }' instead'."
          ActiveSupport::Deprecation.warn message

          options["data-confirm"] = confirm
        end

        content_tag(:button, value, { "type" => "submit", "name" => "commit", "value" => value }.update(options))
      end

    end
  end
end
