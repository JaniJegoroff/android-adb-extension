# Class to handle Android Debug Bridge shell commands
#
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
      `adb shell dumpsys input |
       grep 'SurfaceOrientation' |
       awk '{ print $2 }'`.strip.to_i
    end

    def portrait?
      orientation.to_boolean.eql?(false)
    end

    def landscape?
      orientation.to_boolean.eql?(true)
    end

    def set_portrait
      change_accelerometer_control(0)
      res = change_device_orientation(0)
      change_accelerometer_control(1)
      res.empty? ? nil : res
    end

    def set_landscape
      change_accelerometer_control(0)
      res = change_device_orientation(1)
      change_accelerometer_control(1)
      res.empty? ? nil : res
    end

    def airplane_mode
      `adb shell settings get global airplane_mode_on`.strip.to_i
    end

    def airplane_mode?
      airplane_mode.to_boolean
    end

    def enable_airplane_mode
      change_airplane_mode(1)
    end

    def disable_airplane_mode
      change_airplane_mode(0)
    end

    def monkey(aPackageName, aEventCount = 500)
      `adb shell monkey -p #{aPackageName} #{aEventCount}`
    end

    def help
      public_methods(false)
    end

    alias_method :h, :help

    private

    def change_accelerometer_control(aMode)
      command = 'adb shell content insert'
      param1 = '--uri content://settings/system'
      param2 = '--bind name:s:accelerometer_rotation'
      param3 = "--bind value:i:#{aMode}"

      `#{command} #{param1} #{param2} #{param3}`
    end

    def change_device_orientation(aOrientation)
      command = 'adb shell content insert'
      param1 = '--uri content://settings/system'
      param2 = '--bind name:s:user_rotation'
      param3 = "--bind value:i:#{aOrientation}"

      `#{command} #{param1} #{param2} #{param3}`
    end

    def change_airplane_mode(aMode)
      command1 = "adb shell settings put global airplane_mode_on #{aMode}"
      command2 = 'adb shell am broadcast'
      param1 = '-a android.intent.action.AIRPLANE_MODE'
      param2 = "--ez state #{aMode.to_boolean}"

      `#{command1} & #{command2} #{param1} #{param2}`
    end
  end
end
