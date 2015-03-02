[![Gem Version](https://badge.fury.io/rb/android-adb-extension.svg)](http://badge.fury.io/rb/android-adb-extension)
[![Code Climate](https://codeclimate.com/github/JaniJegoroff/android-adb-extension/badges/gpa.svg)](https://codeclimate.com/github/JaniJegoroff/android-adb-extension)
[![Dependency Status](https://gemnasium.com/JaniJegoroff/android-adb-extension.svg)](https://gemnasium.com/JaniJegoroff/android-adb-extension)

android-adb-extension
==========

Android Debug Bridge extension provides convenient metaclass to execute ADB shell commands.

This gem is useful when working with test automation frameworks like **Calabash-android** and **Appium**.

Installation
==========

In your Gemfile:

`gem 'android-adb-extension'`

Install gem manually:

`$ gem install android-adb-extension`

Tested devices
==========

Current implementation is tested against

> **`Device: HTC One M7`**

> **`SDK: 19`**

> **`Release: 4.4.3`**

Example use cases
==========

Connect your device and enable USB debugging mode

Launch your favorite application which supports portrait and landscape orientations

Launch irb

`$ irb`

Load android-adb-extension

`irb> require 'android-adb-extension'`

Execute `android-adb-extension` commands

SDK version

> **`ADB.sdk`**

Release version

> **`ADB.release`**

Major version

> **`ADB.major`**

Orientation

> **`ADB.orientation`**

> **`ADB.portrait?`**

> **`ADB.landscape?`**

> **`ADB.set_portrait`**

> **`ADB.set_landscape`**

Airplane mode

> **`ADB.airplane_mode`**

> **`ADB.airplane_mode?`**

> **`ADB.enable_airplane_mode`**

> **`ADB.disable_airplane_mode`**

Monkey

> **`ADB.monkey('your.package.name')`** # Default event count is 500

> **`ADB.monkey('your.package.name', 5000)`**

Lock and unlock screen

> **`ADB.lock`**

> **`ADB.unlock`**

Send application to background

> **`ADB.send_to_background`**

Bring application to foreground

> **`ADB.bring_to_foreground('your.package.name', 'path.to.activity')`**

See available methods

> **`ADB.help`**

Did you notice alias methods?

> **`ADB.help`** --> **`ADB.h`**

Run the tests
==========

TODO

License
==========

MIT
