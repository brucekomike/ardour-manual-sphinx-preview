# Working with Ardour-built Plugin Editors
The plugin editor can be shown by double-clicking on the plugin within
the [processor box](@@processor-box). A new window will appear showing
the editor/GUI for the plugin.

<figure class="right">
<img src="/images/example-plugin.png" class="mini" style="width:400px;"
alt="A generic plugin Editor (A-Eq)" />
<figcaption>A generic plugin editor (ACE Compressor)
<ol class="incremental">
<li>Parameters</li>
<li>Description</li>
<li>CPU Profile</li>
<li>Analysis graph</li>
</ol></figcaption>
</figure>

## Generic Plugin Editor

If a plugin does not have its own GUI, Ardour will construct a [generic
plugin editor]{.dfn} from a small set of common control elements. Ardour
will do this even for plugins that have their own, if [Edit \>
Preferences \> GUI \> Use Plugins\' own interface instead of
Ardour\'s]{.kbd .menu} is disabled.

The generic UI can be temporarily switched to by [right]{.kbd .mouse}
clicking on a processor and selecting [Edit with generic controls]{.kbd
.menu}. This is necessary in order to access the [plugin automation
controls](@@automation).

In the generic UI, any controller can be reset to its default state by
[]{.kbd .mod3n}[Left]{.kbd .mouse}-clicking on it.

## Description

This is a rarely used section that displays the contents of the
description metadata of a plugin.

## CPU Profile

This section displays CPU time measurements for the currently opened
plugin. For more information, please see the documentation on the
[Plugin DSP Load window](/troubleshooting/plugin-dsp-load/).

## Analysis Graph

At the bottom of the generic plugin editor, clicking the arrow displays
the [Analysis Graph]{.dfn}.

This graph displays:

- the [transfer function]{style="background-color:black; color:white;"}
  in white,
- the [phase response]{style="background-color:black; color:red;"} in
  red (optional),
- the [post effect
  spectrum]{style="background-color:black; color:green;"} in green.

The [transfer function]{.dfn} plots the output amplitude of the plugin
(considered as a \"black box\") against its input amplitude, along the
audio spectrum.

The [phase response]{.dfn}, that can be switched on or off using the
[Show phase]{.kbd .option} checkbox, plots the phase of the plugins
output against its input phase, along the audio spectrum. The scale is
shown in [yellow]{style="background-color:black; color:yellow;"} on the
right.

The green spectrum plots the [output signal spectrum]{.dfn}, after the
plugin (for tracks that have a signal on).

The [dB scale]{.kbd .menu} selector in the bottom left allows to change
the vertical scale of the graphs.

## MIDI instruments specificities

![The MIDI keyboard in instruments
plugins](/images/instrument_plugins-keyboard.png)

The generic UI provides, for all MIDI instruments plugins, a keyboard,
that can be used either with the mouse, or by using a QWERTY keyboard as
a piano. Both the channel and the velocity can be set above the
keyboard.
