class ADB
  class << self
    def sdk
      `adb shell getprop ro.build.version.sdk`.strip.to_i
    end

    def release
      `adb shell getprop ro.build.version.release`.strip
    end

    def major
      release.chomp.split('.').first.to_i
    end

    def orientation
      `adb shell dumpsys input | grep 'SurfaceOrientation' | awk '{ print $2 }'`.strip.to_i
    end

    def portrait?
      orientation.to_boolean.eql?(false)
    end

    def landscape?
      orientation.to_boolean.eql?(true)
    end

    def set_portrait
      set_accelerometer_control(0)
      res = set_device_orientation(0)
      set_accelerometer_control(1)
      res.empty? ? nil : res
    end

    def set_landscape
      set_accelerometer_control(0)
      res = set_device_orientation(1)
      set_accelerometer_control(1)
      res.empty? ? nil : res
    end

    def airplane_mode
      `adb shell settings get global airplane_mode_on`.strip.to_i
    end

    def airplane_mode?
      airplane_mode.to_boolean
    end

    def enable_airplane_mode
      set_airplane_mode(true)
    end

    def disable_airplane_mode
      set_airplane_mode(false)
    end

    def help
      public_methods(false)
    end

    alias_method :h, :help

    private

    def set_accelerometer_control(aMode)
      `adb shell content insert --uri content://settings/system --bind name:s:accelerometer_rotation --bind value:i:#{aMode}`
    end

    def set_device_orientation(aOrientation)
      `adb shell content insert --uri content://settings/system --bind name:s:user_rotation --bind value:i:#{aOrientation}`
    end

    def set_airplane_mode(aMode)
      bool = aMode.is_a?(TrueClass) || aMode.is_a?(FalseClass)
      int = aMode.is_a?(Integer)

      raise 'invalid parameter' unless bool || int

      if bool
        mode = aMode.eql?(true) ? 1 : 0
        state = aMode
      else
        mode = aMode
        state = aMode.eql?(1) ? true : false
      end

      `adb shell settings put global airplane_mode_on #{mode} & adb shell am broadcast -a android.intent.action.AIRPLANE_MODE --ez state #{state}`
    end
  end
end
