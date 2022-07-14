require 'syskit_basics/models/compositions/joint_position_constant_generator'

module SyskitBasics
    module Compositions
        describe JointPositionConstantGenerator do
            it "sets the names and positions based on the given hash" do
                task = syskit_stub_deploy_configure_and_start(
                    JointPositionConstantGenerator.
                        with_arguments(setpoint: Hash['j0' => 10, 'j1' => 20]))
                assert_equal ['j0', 'j1'], task.values['out'].names
                assert_equal [10, 20], task.values['out'].elements.map(&:position)
            end

            it "returns the value with an updated timestamp" do
                task = syskit_stub_deploy_configure_and_start(
                    JointPositionConstantGenerator.
                        with_arguments(setpoint: Hash['j0' => 10, 'j1' => 20]))
                Timecop.freeze(expected_time = Time.now)
                sample = expect_execution.
                    to { have_one_new_sample task.out_port }
                assert_in_delta expected_time, sample.time, 1e-6
            end
        end
    end
end

