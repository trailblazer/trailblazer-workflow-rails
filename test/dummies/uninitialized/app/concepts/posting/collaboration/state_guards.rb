module Posting::Collaboration
  module StateGuards
    Decider = Trailblazer::Workflow::Collaboration::StateGuards.from_user_hash(
      {
        "⏸︎ Create [10]" => {guard: ->(ctx, model:, **) { model.state == "⏸︎ Create [10]" }},
        "⏸︎ Update [01]" => {guard: ->(ctx, model:, **) { model.state == "⏸︎ Update [01]" }},
      },
      state_table: Generated::StateTable,
    )
  end
end
