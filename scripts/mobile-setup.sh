#!/bin/bash
# MaxregnerOS Mobile UI Setup Script

echo "Setting up MaxregnerOS glassy mobile UI..."

# Install required packages for mobile UI
PACKAGES=(
    "picom"
    "touchegg" 
    "gtk3"
    "gtk4"
    "qt5-base"
    "qt6-base"
    "papirus-icon-theme"
    "firefox"
    "nautilus"
    "gnome-terminal"
    "gedit"
    "network-manager-applet"
    "blueman"
)

for pkg in "${PACKAGES[@]}"; do
    if pacman -Qi "$pkg" &>/dev/null; then
        echo "✓ $pkg already installed"
    else
        echo "Installing $pkg..."
        pacman -S --noconfirm "$pkg" 2>/dev/null || echo "⚠ Could not install $pkg"
    fi
done

# Configure GTK theme for glassy effects
mkdir -p ~/.config/gtk-3.0
tee ~/.config/gtk-3.0/settings.ini > /dev/null << 'GTKEOF'
[Settings]
gtk-theme-name=Adwaita
gtk-icon-theme-name=Papirus
gtk-font-name=Inter 11
gtk-cursor-theme-name=Adwaita
gtk-cursor-theme-size=24
gtk-toolbar-style=GTK_TOOLBAR_BOTH_HORIZ
gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
gtk-button-images=1
gtk-menu-images=1
gtk-enable-event-sounds=1
gtk-enable-input-feedback-sounds=1
gtk-xft-antialias=1
gtk-xft-hinting=1
gtk-xft-hintstyle=hintfull
gtk-xft-rgba=rgb
GTKEOF

# Configure Picom for glassy effects
mkdir -p ~/.config/picom
tee ~/.config/picom/picom.conf > /dev/null << 'PICOMEOF'
# MaxregnerOS Glassy Effects Configuration
backend = "glx";
glx-no-stencil = true;
glx-copy-from-front = false;
glx-no-rebind-pixmap = true;

# Transparency and blur
blur-background = true;
blur-method = "dual_kawase";
blur-strength = 15;
blur-background-exclude = [
    "window_type = 'dock'",
    "window_type = 'desktop'"
];

# Opacity
active-opacity = 0.95;
inactive-opacity = 0.85;
frame-opacity = 0.85;

# Fading
fading = true;
fade-delta = 300;
fade-in-step = 0.03;
fade-out-step = 0.03;

# Shadows
shadow = true;
shadow-radius = 12;
shadow-offset-x = -7;
shadow-offset-y = -7;
shadow-opacity = 0.7;

# Corner radius
corner-radius = 12;
rounded-corners-exclude = [
    "window_type = 'dock'",
    "window_type = 'desktop'"
];
PICOMEOF

# Configure Touchegg for gestures
mkdir -p ~/.config/touchegg
tee ~/.config/touchegg/touchegg.conf > /dev/null << 'TOUCHEOF'
<touchegg>
  <settings>
    <property name="animation_delay">150</property>
    <property name="action_execute_threshold">20</property>
    <property name="color">auto</property>
    <property name="borderColor">auto</property>
  </settings>
  
  <application name="All">
    <gesture type="SWIPE" fingers="3" direction="UP">
      <action type="SHOW_DESKTOP">
        <animate>true</animate>
      </action>
    </gesture>
    
    <gesture type="SWIPE" fingers="3" direction="DOWN">
      <action type="SHOW_DESKTOP">
        <animate>true</animate>
      </action>
    </gesture>
    
    <gesture type="SWIPE" fingers="3" direction="LEFT">
      <action type="CHANGE_DESKTOP">
        <direction>next</direction>
        <animate>true</animate>
      </action>
    </gesture>
    
    <gesture type="SWIPE" fingers="3" direction="RIGHT">
      <action type="CHANGE_DESKTOP">
        <direction>previous</direction>
        <animate>true</animate>
      </action>
    </gesture>
    
    <gesture type="SWIPE" fingers="4" direction="UP">
      <action type="RUN_COMMAND">
        <command>gnome-control-center</command>
      </action>
    </gesture>
  </application>
</touchegg>
TOUCHEOF

echo "MaxregnerOS glassy mobile UI setup completed!"
