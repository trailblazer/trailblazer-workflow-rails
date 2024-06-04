require_relative "test_helper"

class ImportTest < Minitest::Spec
  include ExecuteInRails

  let(:api_key) { "tpka_909ae987_c834_43e4_9869_2eefd2aa9bcf" }
  let(:trailblazer_pro_host) { "https://testbackend-pro.trb.to" }

  after do
    # Dir.chdir("test/dummies/uninitialized") do
    #   `rm tmp/trb-pro` #if File.exist?("tmp/trb-pro")
    # end
    `rm /tmp/79d163.json`
  end

  it "retrieve document" do
    Dir.chdir("test/dummies/uninitialized") do
      `rm -r tmp/trb-pro` if File.exist?("tmp/trb-pro")

      cli = File.popen({"BUNDLE_GEMFILE" => "../Gemfile"}, "bin/rails.rb g trailblazer:pro:install", "r+")
      cli.write "#{api_key}\n"
      cli.close

      json = File.read("tmp/trb-pro/session")
      json = json.sub("https://pro.trailblazer.to", trailblazer_pro_host)
      File.write("tmp/trb-pro/session", json) # FIXME: what do you mean? This is super clean :D


      cli = File.popen({"BUNDLE_GEMFILE" => "../Gemfile"}, "bin/rails.rb g trailblazer:pro:import 79d163 /tmp/79d163.json", "r+")
      assert_equal read_from_cli(cli)[1], %(Diagram 79d163 successfully imported to /tmp/79d163.json.\n)
      cli.close

      assert File.exist?("/tmp/79d163.json")
      # TODO: use template from trailblazer-pro test suite.
      # puts File.read("/tmp/79d163.json")
      assert_equal File.read("/tmp/79d163.json"), %({\"id\":4,\"type\":\"collaboration\",\"lanes\":[{\"id\":\"⛾.lifecycle.lifecycle\",\"type\":\"lane\",\"elements\":[{\"id\":\"Event_1q1vom7\",\"label\":\"failure\",\"type\":\"terminus\",\"data\":{},\"links\":[]},{\"id\":\"Event_1vobcpt\",\"label\":\"success\",\"type\":\"terminus\",\"data\":{},\"links\":[]},{\"id\":\"Event_08wf2ba\",\"label\":\"created?\",\"type\":\"catch_event\",\"data\":{},\"links\":[{\"target_id\":\"suspend-gw-to-catch-before-Activity_09iqmyp\",\"semantic\":\"success\"}]},{\"id\":\"Event_1ubzvz7\",\"label\":\"invalid?\",\"type\":\"catch_event\",\"data\":{},\"links\":[{\"target_id\":\"Event_1e4hu5l\",\"semantic\":\"success\"}]},{\"id\":\"Event_05djf63\",\"label\":\"updated?\",\"type\":\"catch_event\",\"data\":{},\"links\":[{\"target_id\":\"Event_1vobcpt\",\"semantic\":\"success\"}]},{\"id\":\"Event_1e4hu5l\",\"label\":\"invalid?\",\"type\":\"catch_event\",\"data\":{},\"links\":[{\"target_id\":\"Event_1q1vom7\",\"semantic\":\"success\"}]},{\"id\":\"Activity_09iqmyp\",\"label\":\"Update\",\"type\":\"task\",\"data\":{},\"links\":[{\"target_id\":\"throw-after-Activity_09iqmyp\",\"semantic\":\"success\"}]},{\"id\":\"Activity_1ez39aa\",\"label\":\"Create\",\"type\":\"task\",\"data\":{},\"links\":[{\"target_id\":\"throw-after-Activity_1ez39aa\",\"semantic\":\"success\"}]},{\"id\":\"catch-before-Activity_1ez39aa\",\"label\":null,\"type\":\"catch_event\",\"data\":{\"start_task\":true},\"links\":[{\"target_id\":\"Activity_1ez39aa\",\"semantic\":\"success\"}]},{\"id\":\"throw-after-Activity_1ez39aa\",\"label\":null,\"type\":\"throw_event\",\"data\":{},\"links\":[{\"target_id\":\"suspend-Gateway_0rsmajn\",\"semantic\":\"success\"}]},{\"id\":\"catch-before-Activity_09iqmyp\",\"label\":null,\"type\":\"catch_event\",\"data\":{},\"links\":[{\"target_id\":\"Activity_09iqmyp\",\"semantic\":\"success\"}]},{\"id\":\"throw-after-Activity_09iqmyp\",\"label\":null,\"type\":\"throw_event\",\"data\":{},\"links\":[{\"target_id\":\"suspend-Gateway_0ik4jq7\",\"semantic\":\"success\"}]},{\"id\":\"suspend-Gateway_0rsmajn\",\"label\":null,\"type\":\"suspend\",\"data\":{\"resumes\":[\"Event_08wf2ba\",\"Event_1ubzvz7\"]},\"links\":[]},{\"id\":\"suspend-Gateway_0ik4jq7\",\"label\":null,\"type\":\"suspend\",\"data\":{\"resumes\":[\"Event_05djf63\",\"Event_1e4hu5l\"]},\"links\":[]},{\"id\":\"suspend-gw-to-catch-before-Activity_1ez39aa\",\"label\":null,\"type\":\"suspend\",\"data\":{\"resumes\":[\"catch-before-Activity_1ez39aa\"]},\"links\":[]},{\"id\":\"suspend-gw-to-catch-before-Activity_09iqmyp\",\"label\":null,\"type\":\"suspend\",\"data\":{\"resumes\":[\"catch-before-Activity_09iqmyp\"]},\"links\":[]}]},{\"id\":\"☑.engine.engine\",\"type\":\"lane\",\"elements\":[{\"id\":\"Event_1bnkbsv\",\"label\":\"invalid!\",\"type\":\"throw_event\",\"data\":{},\"links\":[{\"target_id\":\"suspend-gw-to-catch-before-Activity_0i2r3tw\",\"semantic\":\"success\"}]},{\"id\":\"Event_0s0ater\",\"label\":\"success\",\"type\":\"terminus\",\"data\":{},\"links\":[]},{\"id\":\"Activity_1g6hk1o\",\"label\":\"Modify\",\"type\":\"task\",\"data\":{},\"links\":[{\"target_id\":\"throw-after-Activity_1g6hk1o\",\"semantic\":\"success\"},{\"target_id\":\"Event_0x5o7t7\",\"semantic\":\"failure\"}]},{\"id\":\"Event_0x5o7t7\",\"label\":\"invalid!\",\"type\":\"throw_event\",\"data\":{},\"links\":[{\"target_id\":\"suspend-gw-to-catch-before-Activity_1g6hk1o\",\"semantic\":\"success\"}]},{\"id\":\"Activity_0i2r3tw\",\"label\":\"Instantiate\",\"type\":\"task\",\"data\":{},\"links\":[{\"target_id\":\"throw-after-Activity_0i2r3tw\",\"semantic\":\"success\"},{\"target_id\":\"Event_1bnkbsv\",\"semantic\":\"failure\"}]},{\"id\":\"catch-before-Activity_0i2r3tw\",\"label\":null,\"type\":\"catch_event\",\"data\":{\"start_task\":true},\"links\":[{\"target_id\":\"Activity_0i2r3tw\",\"semantic\":\"success\"}]},{\"id\":\"throw-after-Activity_0i2r3tw\",\"label\":null,\"type\":\"throw_event\",\"data\":{},\"links\":[{\"target_id\":\"suspend-gw-to-catch-before-Activity_1g6hk1o\",\"semantic\":\"success\"}]},{\"id\":\"catch-before-Activity_1g6hk1o\",\"label\":null,\"type\":\"catch_event\",\"data\":{},\"links\":[{\"target_id\":\"Activity_1g6hk1o\",\"semantic\":\"success\"}]},{\"id\":\"throw-after-Activity_1g6hk1o\",\"label\":null,\"type\":\"throw_event\",\"data\":{},\"links\":[{\"target_id\":\"Event_0s0ater\",\"semantic\":\"success\"}]},{\"id\":\"suspend-gw-to-catch-before-Activity_0i2r3tw\",\"label\":null,\"type\":\"suspend\",\"data\":{\"resumes\":[\"catch-before-Activity_0i2r3tw\"]},\"links\":[]},{\"id\":\"suspend-gw-to-catch-before-Activity_1g6hk1o\",\"label\":null,\"type\":\"suspend\",\"data\":{\"resumes\":[\"catch-before-Activity_1g6hk1o\"]},\"links\":[]}]}],\"messages\":[[[\"☑.engine.engine\",\"Event_1bnkbsv\"],[\"⛾.lifecycle.lifecycle\",\"Event_1ubzvz7\"]],[[\"☑.engine.engine\",\"Event_0x5o7t7\"],[\"⛾.lifecycle.lifecycle\",\"Event_1e4hu5l\"]],[[\"⛾.lifecycle.lifecycle\",\"throw-after-Activity_1ez39aa\"],[\"☑.engine.engine\",\"catch-before-Activity_0i2r3tw\"]],[[\"⛾.lifecycle.lifecycle\",\"throw-after-Activity_09iqmyp\"],[\"☑.engine.engine\",\"catch-before-Activity_1g6hk1o\"]],[[\"☑.engine.engine\",\"throw-after-Activity_0i2r3tw\"],[\"⛾.lifecycle.lifecycle\",\"Event_08wf2ba\"]],[[\"☑.engine.engine\",\"throw-after-Activity_1g6hk1o\"],[\"⛾.lifecycle.lifecycle\",\"Event_05djf63\"]]]})
    end
  end

  it "retrieve document with invalid credentials" do
    Dir.chdir("test/dummies/uninitialized") do
      `rm -r tmp/trb-pro` #if File.exist?("tmp/trb-pro")

      cli = File.popen({"BUNDLE_GEMFILE" => "../Gemfile"}, "bin/rails.rb g trailblazer:pro:install", "r+")
      cli.write "#{api_key}-XXX\n"
      cli.close

      json = File.read("tmp/trb-pro/session")
      json = json.sub("https://pro.trailblazer.to", trailblazer_pro_host)
      File.write("tmp/trb-pro/session", json) # FIXME: what do you mean? This is super clean :D

      stderr_to_stdout = "2>&1"
      cli = File.popen({"BUNDLE_GEMFILE" => "../Gemfile"}, "bin/rails.rb g trailblazer:pro:import 79d163 /tmp/79d163.json 2>&1", "r+")
      lines, last_lines = read_from_cli(cli)

      # assert_equal last_line, %(asdf Diagram 79d163 successfully imported to /tmp/79d163.json.\n)
      assert lines.find { |line| line =~ /TRB PRO] error: Custom token couldn't be retrieved. HTTP status: 401 \(RuntimeError\)/ }

      cli.close

      assert ! File.exist?("/tmp/79d163.json")
    end
  end
end
