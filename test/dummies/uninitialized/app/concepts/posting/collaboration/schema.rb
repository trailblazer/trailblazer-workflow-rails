module Posting::Collaboration
  Schema = Trailblazer::Workflow.Collaboration(
    json_file: "/tmp/79d163.json",
    lanes: {
      "⛾.lifecycle.lifecycle" => {
        label: "lifecycle",
        icon:  "⛾",
        implementation: {
          "Update" => Trailblazer::Activity::Railway.Subprocess(Posting::Collaboration::Update),
          "Create" => Trailblazer::Activity::Railway.Subprocess(Posting::Collaboration::Create),
        }
      },
      "☑.engine.engine" => {
        label: "engine",
        icon:  "☑",
        implementation: {
          "Modify" => Trailblazer::Activity::Railway.Subprocess(Posting::Collaboration::Modify),
          "Instantiate" => Trailblazer::Activity::Railway.Subprocess(Posting::Collaboration::Instantiate),
        }
      },
    }, # :lanes
    state_guards: Posting::Collaboration::StateGuards::Decider,
  )
end
