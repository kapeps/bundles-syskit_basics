require 'common_models/models/compositions/constant_generator'
import_types_from 'base'

module SyskitBasics
    module Compositions
        class JointPositionConstantGenerator <
            CommonModels::Compositions::ConstantGenerator.
                for('/base/commands/Joints')

            # The setpoint as a hash of joint names to joint positions
            argument :setpoint

            def setpoint=(setpoint)
                joint_names    = setpoint.keys
                joint_commands = setpoint.each_value.map do |position|
                    Types.base.JointState.new(
                        position: position,
                        speed: Float::NAN,
                        effort: Float::NAN,
                        raw: Float::NAN,
                        acceleration: Float::NAN)
                end
                self.values = Hash['out' =>
                    Types.base.commands.Joints.new(
                        time: Time.at(0),
                        names: joint_names,
                        elements: joint_commands)]
            end

            def values
                if v = super
                    # Do not change the argument "under the hood"
                    sample = v['out'].dup
                    sample.time = Time.now
                    Hash['out' => sample]
                end
            end
        end
    end
end

