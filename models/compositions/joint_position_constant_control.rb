require 'common_models/models/devices/gazebo/model'
require 'syskit_basics/models/compositions/joint_position_constant_generator'

module SyskitBasics
    module Compositions
        class JointPositionConstantControl < Syskit::Composition
            # The setpoint as a 'joint_name' => position_in_radians hash
            argument :setpoint

            add CommonModels::Devices::Gazebo::Model, as: 'arm'
            add(JointPositionConstantGenerator, as: 'command').
                with_arguments(setpoint: from(:parent_task).setpoint)

            command_child.out_port.connect_to \
                arm_child.joints_cmd_port
        end
    end
end

