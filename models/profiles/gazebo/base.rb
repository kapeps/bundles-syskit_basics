# frozen_string_literal: true

module SyskitBasics
    module Profiles
        module Gazebo #:nodoc:
            profile "Base" do
                use_gazebo_model 'model://ur10',
                    prefix_device_with_name: true
                use_sdf_world
            end
        end
    end
end

