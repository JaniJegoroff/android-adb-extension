# Class to handle Android Debug Bridge shell commands
#
class ADB
  class << self
    def sdk
      `#{adb_shell_command} getprop ro.build.version.sdk`.strip.to_i
    end

    def release
      `#{adb_shell_command} getprop ro.build.version.release`.strip
    end

    def major
      release.chomp.split('.').first.to_i
    end

    def serial
      `#{adb_shell_command} getprop ro.serialno`.strip
    end

    def device_name
      `#{adb_shell_command} getprop ro.product.model`.strip
    end

    def orientation
      `#{adb_shell_command} dumpsys input |
       grep 'SurfaceOrientation' |
       awk '{ print $2 }'`.strip.to_i
    end

    def portrait?
      rotation = orientation
      rotation.eql?(0) || rotation.eql?(2)
    end

    def landscape?
      rotation = orientation
      rotation.eql?(1) || rotation.eql?(3)
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
      `#{adb_shell_command} settings get global airplane_mode_on`.strip.to_i
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

    def monkey(package, event_count = 500)
      `#{adb_shell_command} monkey -p #{package} #{event_count}`
    end

    def lock
      cmd = "#{adb_shell_command} input keyevent 26"
      `#{cmd}`
      res = `#{cmd}`
      res.empty? ? nil : res
    end

    def unlock
      res = `#{adb_shell_command} input keyevent 82`
      res.empty? ? nil : res
    end

    def send_to_background
      res = `#{adb_shell_command} input keyevent 3`
      res.empty? ? nil : res
    end

    def bring_to_foreground(package, activity)
      res = `#{adb_shell_command} am start -n #{package}/#{activity}`
      res.empty? ? nil : res
    end

    def reset_app(package)
      res = `#{adb_shell_command} pm clear #{package}`
      res.empty? ? nil : res
    end

    def stop_app(package)
      res = `#{adb_shell_command} am force-stop #{package}`
      res.empty? ? nil : res
    end

    def uninstall_app(package)
      res = `#{adb_shell_command} pm uninstall #{package}`
      res.empty? ? nil : res
    end

    def start_intent(uri)
      res = `#{adb_shell_command} am start -a android.intent.action.VIEW -d #{uri}`
      res.empty? ? nil : res
    end

    def input_text(text)
      res = `#{adb_shell_command} input text #{text}`
      res.empty? ? nil : res
    end

    def take_screenshot(file_name)
      res = `#{adb_shell_command} screencap -p | perl -pe 's/\x0D\x0A/\x0A/g' > #{file_name}.png`
      res.empty? ? nil : res
    end

    def swipe(x1, y1, x2, y2, duration = nil)
      args = duration.nil? ? "#{x1} #{y1} #{x2} #{y2}" : "#{x1} #{y1} #{x2} #{y2} #{duration}"
      res = `#{adb_shell_command} input swipe #{args}`
      res.empty? ? nil : res
    end

    def help
      public_methods(false)
    end

    alias h help

    private

    def change_accelerometer_control(mode)
      adb_settings_system_command('accelerometer_rotation', mode)
    end

    def change_device_orientation(orientation)
      adb_settings_system_command('user_rotation', orientation)
    end

    def adb_settings_system_command(name, value)
      command = "#{adb_shell_command} content insert"
      param1 = '--uri content://settings/system'
      param2 = "--bind name:s:#{name}"
      param3 = "--bind value:i:#{value}"

      `#{command} #{param1} #{param2} #{param3}`
    end

    def change_airplane_mode(mode)
      command1 = "#{adb_shell_command} settings put global airplane_mode_on #{mode}"
      command2 = "#{adb_shell_command} am broadcast"
      param1 = '-a android.intent.action.AIRPLANE_MODE'
      param2 = "--ez state #{mode.to_boolean}"

      `#{command1} & #{command2} #{param1} #{param2}`
    end

    def adb_shell_command
      'adb shell'
    end
  end
end
