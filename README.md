# Fusion Settings

A settings manager plugin for godot, using resources to define the settings.

# Installation

Download Fusion Settings from the asset store or install it from the releases section of github. Enable the plugin in the project settings.

# Usage

## Defining a Setting

To define a setting, create a resource of type `FusionSetting`, `FusionRangeSetting`, or `FusionListSetting`. Set the `title` and `default_value`. The `default_value` is of `Variant` type. It takes advantage of Godot 4.5's new type picker for `Variant` values.

Optionally [attach a script](#apply-script), write a [description](#description), or [specifiy a key and section for saving](#key-and-section).

### Types

`FusionSetting` is the base setting type. It's best for booleans, strings, and colors.

`FusionRangeSetting` is the setting type for a range slider. There are min, max, and step options.

`FusionListSetting` is the setting type for an option list dropdown menu. It has two arrays, one for the names of the options, and one for the values associated with the options.

For more information on which type to use see [Creating a Settings Menu](#creating-a-settings-menu)

### Apply Script

This script should contain the function `static func apply(value: Variant) -> void`. It can contain other functions. `apply()` is called with the value of the function. This function should apply the setting to the game. This is not the only way to use the settings. [The value of settings can also be accessed from other scripts.](#accessing-the-settings)

### Description

The description of the setting will display as a tooltip when hovered over the setting in a menu. [Setting menu creation is detailed here.](#creating-a-settings-menu)

### Key and Section

The key and section to save a setting under in the config file can be specified here. If these aren't set, the title will be used as a key and a default value will be used for the section.

## Automatically Applying the Setting at Startup

Any FusionSetting resources saved under the autoload path will have apply called on game start. By default, the directory is `res://settings/`, but can be changed in the fusion compute section of the project settings.

## Accessing the Settings

Often it is useful to access setting values outside of the apply function. Since resources are global in godot, unless otherwise specified, it is easy to access the setting resource. For example:

```gdscript
const FOO_SETTING = preload("res://settings/foo_setting.tres")

@export var foo_setting: FusionSetting
```

Getting the value is as simple as calling `get_value()` on the resource object. For example:

```gdscript
var value: Variant = foo_setting.get_value()
```

## Creating a Settings Menu

A `FusionSettingDisplay` node is provided to easily set up a setting item in a menu. Any type of FusionSetting can be attached to it. It will set everything up automatically. See [the example project](addons/fusion_settings/example/) for a demonstration.

## Plugin Settings

There are two settings in the `ProjectSettings` under `Fusion Settings`.

`Autoload Path` is an array of directories to search for setting resources to apply at startup.

`Config Save Path` is the path to save the file containing the data for settings.

## Extending

Todo
