module Trailblazer
  module Pro
    class Import < ::Rails::Generators::Base
      # source_root File.expand_path("templates", __dir__)
      argument :slug, type: :string, default: nil, banner: "Diagram slug"
      argument :target, type: :string, default: nil, banner: "Target filename"

      def import_file_via_api
        # TODO: use endpoint logic here.
        signal, (ctx, _) = Trailblazer::Developer.wtf?(Trailblazer::Workflow::Task::Import, [
          {
            diagram_slug: slug,
            target_filename: target,
            session: Trailblazer::Pro::Session.session
          },
          {}
        ])

        return puts("Diagram #{slug} successfully imported to #{target}.") if signal.to_h[:semantic] == :success
        raise "[TRB PRO] error: #{ctx[:error_message]}"
      end
    end # Import
  end
end
