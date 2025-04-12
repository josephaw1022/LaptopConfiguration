#!/bin/bash

# Desired pinned apps
FAVORITES="[
  'com.brave.Browser.desktop',
  'org.mozilla.Thunderbird.desktop',
  'code.desktop',
  'app.devsuite.Ptyxis.desktop',
  'io.podman_desktop.PodmanDesktop.desktop',
  'io.kinvolk.Headlamp.desktop',
  'org.pgadmin.pgadmin4.desktop',
  'me.iepure.devtoolbox.desktop',
  'com.vixalien.sticky.desktop',
  'com.spotify.Client.desktop',
  'org.gnome.Calendar.desktop',
  'org.gnome.Nautilus.desktop',
  'org.gnome.Software.desktop',
  'org.gnome.TextEditor.desktop'
]"

# Apply it
gsettings set org.gnome.shell favorite-apps "$FAVORITES"
