=begin
  +-----------------+----------------------------------------+---------------------------------------------+
| triggered catch | start configuration                    | expected reached configuration              |
+-----------------+----------------------------------------+---------------------------------------------+
| ⛾ ⏵︎Create       | ⛾ ⏵︎Create <1ez3> ☑ ⏵︎Instantiate <0i2r> | ⛾ ⏵︎Update <09iq>      ☑ ⏵︎Modify <1g6h>      |
| ⛾ ⏵︎Create ⛞     | ⛾ ⏵︎Create <1ez3> ☑ ⏵︎Instantiate <0i2r> | ⛾ ◉End.failure <1q1v> ☑ ⏵︎Instantiate <0i2r> |
| ⛾ ⏵︎Update       | ⛾ ⏵︎Update <09iq> ☑ ⏵︎Modify <1g6h>      | ⛾ ◉End.success <1vob> ☑ ◉End.success <0s0a> |
| ⛾ ⏵︎Update ⛞     | ⛾ ⏵︎Update <09iq> ☑ ⏵︎Modify <1g6h>      | ⛾ ◉End.failure <1q1v> ☑ ⏵︎Modify <1g6h>      |
+-----------------+----------------------------------------+---------------------------------------------+
=end

  require "test_helper"

  class Posting_CollaborationCollaborationTest < Minitest::Spec
    include Trailblazer::Workflow::Test::Assertions
    require "trailblazer/test/assertions"
    include Trailblazer::Test::Assertions # DISCUSS: this is for assert_advance and friends.

    it "can run the collaboration" do
      schema = Posting::Collaboration::Schema
      test_plan = Trailblazer::Workflow::Introspect::Iteration::Set::Deserialize.(JSON.parse(File.read("app/concepts/posting/collaboration/generated/iteration_set.json")), lanes_cfg: schema.to_h[:lanes])

      
# test: ⛾ ⏵︎Create
ctx = assert_advance "⛾ ⏵︎Create", test_plan: test_plan, schema: schema
assert_exposes ctx, seq: [:revise, :revise], reader: :[]


# test: ⛾ ⏵︎Create ⛞
ctx = assert_advance "⛾ ⏵︎Create ⛞", test_plan: test_plan, schema: schema
assert_exposes ctx, seq: [:revise, :revise], reader: :[]


# test: ⛾ ⏵︎Update
ctx = assert_advance "⛾ ⏵︎Update", test_plan: test_plan, schema: schema
assert_exposes ctx, seq: [:revise, :revise], reader: :[]


# test: ⛾ ⏵︎Update ⛞
ctx = assert_advance "⛾ ⏵︎Update ⛞", test_plan: test_plan, schema: schema
assert_exposes ctx, seq: [:revise, :revise], reader: :[]

    end
  end
  