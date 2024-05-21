require_relative "test_helper"

class DiscoverTest < Minitest::Spec
  include ExecuteInRails

  let(:api_key) { "tpka_909ae987_c834_43e4_9869_2eefd2aa9bcf" }
  let(:trailblazer_pro_host) { "https://testbackend-pro.trb.to" }

  after do
    Dir.chdir("test/dummies/uninitialized") do
      `rm app/concepts/posting/collaboration/state_guards.rb` #if File.exist?("tmp/trb-pro")
      `rm -r app/concepts/posting/collaboration/generated` #if File.exist?("tmp/trb-pro")
    end
  end

  it "creates files for discovered PRO diagram" do
    Dir.chdir("test/dummies/uninitialized") do
      cli = File.popen({"BUNDLE_GEMFILE" => "../Gemfile"}, "bin/rails.rb g trailblazer:pro:install", "r+")
      cli.write "#{api_key}\n"
      cli.close

      json = File.read("tmp/trb-pro/session")
      json = json.sub("https://pro.trailblazer.to", trailblazer_pro_host)
      File.write("tmp/trb-pro/session", json) # FIXME: what do you mean? This is super clean :D

      # Import.
      cli = File.popen({"BUNDLE_GEMFILE" => "../Gemfile"}, "bin/rails.rb g trailblazer:pro:import 79d163 /tmp/79d163.json", "r+")
      assert_equal read_from_cli(cli)[1], %(Diagram 79d163 successfully imported to /tmp/79d163.json.\n)

# TODO: now, we should infer/generate {app/concepts/posting/collaboration/schema.rb}.
# rails g trailblazer:pro:discover app/concepts/posting/collaboration/generated/posting-v11.json --namespace Posting::Collaboration --test test/posting_collaboration_test.rb --start_lane UI --failure UI:Create,⛾.lifecycle.posting:Create --failure UI:Update,⛾.lifecycle.posting:Update --failure UI:Revise,⛾.lifecycle.posting:Revise

      cli = File.popen({"BUNDLE_GEMFILE" => "../Gemfile"}, %(bin/rails.rb g trailblazer:pro:discover \
/tmp/79d163.json  \
--namespace Posting::Collaboration  \
--test test/posting_collaboration_test.rb \
--start_lane "lifecycle" \
--failure lifecycle:Create,☑.engine.engine:Instantiate --failure lifecycle:Update,☑.engine.engine:Modify \
), "r+")

      assert_equal read_from_cli(cli)[1], %(Discovered 4 states.\n)
      cli.close

      assert File.exist?(filename = "app/concepts/posting/collaboration/generated/iteration_set.json")
      assert_equal File.read(filename).size, 5289
      assert File.exist?(filename = "app/concepts/posting/collaboration/generated/state_table.rb")
      assert_equal File.read(filename).size, 574
      assert File.exist?(filename = "app/concepts/posting/collaboration/state_guards.rb")
      assert_equal File.read(filename).size, 394
      assert File.exist?(filename = "app/concepts/posting/collaboration/schema.rb")
      assert_equal File.read(filename).size, 859
    end
  end
end
