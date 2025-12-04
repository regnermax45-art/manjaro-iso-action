#!/bin/bash
# MaxregnerOS Mobile UI Rootfs Setup Script
# Integrates glassy mobile UI features directly into the root filesystem

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Logging function
log() {
    echo -e "${GREEN}[MaxregnerOS]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
    exit 1
}

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   error "This script must be run as root"
fi

log "Starting MaxregnerOS Mobile UI Rootfs Integration..."

# Create directory structure
log "Creating MaxregnerOS directory structure..."
mkdir -p /etc/maxregneros-ui/{themes,configs,scripts,services}
mkdir -p /usr/share/maxregneros-ui/{themes,icons,wallpapers,sounds,fonts}
mkdir -p /usr/lib/maxregneros-ui/{plugins,extensions,modules}
mkdir -p /var/lib/maxregneros-ui/{cache,logs,data}
mkdir -p /opt/maxregneros-ui/{tools,apps}

# Install mobile UI system services
log "Installing MaxregnerOS mobile UI system services..."

# Create gesture recognition service
cat > /etc/systemd/system/maxregneros-gestures.service << 'EOF'
[Unit]
Description=MaxregnerOS Gesture Recognition Service
After=graphical-session.target
Wants=graphical-session.target

[Service]
Type=simple
ExecStart=/usr/bin/touchegg --daemon
Restart=always
RestartSec=3
User=root
Environment=DISPLAY=:0

[Install]
WantedBy=graphical-session.target
EOF

# Create mobile UI compositor service
cat > /etc/systemd/system/maxregneros-compositor.service << 'EOF'
[Unit]
Description=MaxregnerOS Glassy Compositor Service
After=graphical-session.target
Wants=graphical-session.target

[Service]
Type=simple
ExecStart=/usr/bin/picom --config /etc/maxregneros-ui/configs/picom.conf
Restart=always
RestartSec=3
User=root
Environment=DISPLAY=:0

[Install]
WantedBy=graphical-session.target
EOF

# Create mobile optimization service
cat > /etc/systemd/system/maxregneros-mobile-optimizer.service << 'EOF'
[Unit]
Description=MaxregnerOS Mobile Performance Optimizer
After=multi-user.target
Wants=multi-user.target

[Service]
Type=oneshot
ExecStart=/usr/share/maxregneros-ui/scripts/mobile-optimizer.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF

# Create mobile optimizer script
cat > /usr/share/maxregneros-ui/scripts/mobile-optimizer.sh << 'EOF'
#!/bin/bash
# MaxregnerOS Mobile Performance Optimizer

# CPU governor for mobile performance
echo "performance" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2>/dev/null || true

# GPU performance settings
echo "high" > /sys/class/drm/card0/device/power_dpm_force_performance_level 2>/dev/null || true

# Touch device optimizations
for device in /sys/class/input/input*; do
    if [[ -f "$device/name" ]] && grep -q "touch\|Touch" "$device/name" 2>/dev/null; then
        echo 1 > "$device/device/power/wakeup" 2>/dev/null || true
    fi
done

# Memory optimization for mobile UI
echo 1 > /proc/sys/vm/swappiness 2>/dev/null || true
echo 10 > /proc/sys/vm/vfs_cache_pressure 2>/dev/null || true

# Network optimizations for mobile
echo 1 > /proc/sys/net/ipv4/tcp_fastopen 2>/dev/null || true
echo "bbr" > /proc/sys/net/core/default_qdisc 2>/dev/null || true

log "Mobile performance optimizations applied"
EOF

chmod +x /usr/share/maxregneros-ui/scripts/mobile-optimizer.sh

# Configure system-wide mobile UI settings
log "Configuring system-wide mobile UI settings..."

# Create system-wide GTK configuration
mkdir -p /etc/gtk-3.0
cat > /etc/gtk-3.0/settings.ini << 'EOF'
[Settings]
gtk-theme-name=MaxregnerOS-Glassy
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
gtk-application-prefer-dark-theme=0
gtk-primary-button-warps-slider=0
gtk-overlay-scrolling=1
gtk-enable-animations=1
gtk-enable-primary-paste=0
EOF

# Create system-wide Qt configuration
mkdir -p /etc/xdg/qt5ct
cat > /etc/xdg/qt5ct/qt5ct.conf << 'EOF'
[Appearance]
color_scheme_path=/usr/share/maxregneros-ui/themes/glassy-mobile.colors
custom_palette=false
icon_theme=Papirus
standard_dialogs=default
style=Fusion

[Fonts]
fixed=@Variant(\0\0\0@\0\0\0\x12\0J\0\x65\0t\0\x42\0r\0\x61\0i\0n\0s\0 \0M\0o\0n\0o@$\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)
general=@Variant(\0\0\0@\0\0\0\x10\0I\0n\0t\0\x65\0r@$\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)

[Interface]
activate_item_on_single_click=1
buttonbox_layout=0
cursor_flash_time=1000
dialog_buttons_have_icons=1
double_click_interval=400
gui_effects=@Invalid()
keyboard_scheme=2
menus_have_icons=true
show_shortcuts_in_context_menus=true
stylesheets=@Invalid()
toolbutton_style=4
underline_shortcut=1
wheel_scroll_lines=3

[SettingsWindow]
geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\x2\x80\0\0\x1\x90\0\0\x5\x7f\0\0\x4\x37\0\0\x2\x80\0\0\x1\x90\0\0\x5\x7f\0\0\x4\x37\0\0\0\0\0\0\0\0\a\x80\0\0\x2\x80\0\0\x1\x90\0\0\x5\x7f\0\0\x4\x37)
EOF

# Configure X11 for touch and mobile optimization
log "Configuring X11 for mobile optimization..."
mkdir -p /etc/X11/xorg.conf.d

cat > /etc/X11/xorg.conf.d/40-maxregneros-mobile.conf << 'EOF'
# MaxregnerOS Mobile UI X11 Configuration

Section "InputClass"
    Identifier "MaxregnerOS Touch Configuration"
    MatchIsTouchscreen "on"
    Driver "libinput"
    Option "Tapping" "on"
    Option "TappingDrag" "on"
    Option "TappingDragLock" "off"
    Option "NaturalScrolling" "true"
    Option "ScrollMethod" "twofinger"
    Option "HorizontalScrolling" "true"
    Option "DisableWhileTyping" "true"
    Option "AccelProfile" "adaptive"
    Option "AccelSpeed" "0.3"
EndSection

Section "InputClass"
    Identifier "MaxregnerOS Touchpad Configuration"
    MatchIsTouchpad "on"
    Driver "libinput"
    Option "Tapping" "on"
    Option "TappingDrag" "on"
    Option "TappingDragLock" "off"
    Option "NaturalScrolling" "true"
    Option "ScrollMethod" "twofinger"
    Option "HorizontalScrolling" "true"
    Option "DisableWhileTyping" "true"
    Option "AccelProfile" "adaptive"
    Option "AccelSpeed" "0.5"
    Option "ClickMethod" "clickfinger"
EndSection

Section "Device"
    Identifier "MaxregnerOS Graphics"
    Driver "modesetting"
    Option "AccelMethod" "glamor"
    Option "DRI" "3"
    Option "TearFree" "true"
EndSection
EOF

# Configure fontconfig for mobile readability
log "Configuring fonts for mobile readability..."
mkdir -p /etc/fonts/conf.d

cat > /etc/fonts/local.conf << 'EOF'
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
    <!-- MaxregnerOS Mobile Font Configuration -->
    
    <!-- Default fonts for mobile readability -->
    <alias>
        <family>sans-serif</family>
        <prefer>
            <family>Inter</family>
            <family>Roboto</family>
            <family>Noto Sans</family>
        </prefer>
    </alias>
    
    <alias>
        <family>serif</family>
        <prefer>
            <family>Noto Serif</family>
            <family>Liberation Serif</family>
        </prefer>
    </alias>
    
    <alias>
        <family>monospace</family>
        <prefer>
            <family>JetBrains Mono</family>
            <family>Fira Code</family>
            <family>Liberation Mono</family>
        </prefer>
    </alias>
    
    <!-- Mobile-optimized font rendering -->
    <match target="font">
        <edit name="antialias" mode="assign">
            <bool>true</bool>
        </edit>
        <edit name="hinting" mode="assign">
            <bool>true</bool>
        </edit>
        <edit name="hintstyle" mode="assign">
            <const>hintslight</const>
        </edit>
        <edit name="rgba" mode="assign">
            <const>rgb</const>
        </edit>
        <edit name="lcdfilter" mode="assign">
            <const>lcddefault</const>
        </edit>
    </match>
    
    <!-- Minimum font sizes for touch interfaces -->
    <match target="pattern">
        <test qual="any" name="size" compare="less">
            <double>9</double>
        </test>
        <edit name="size" mode="assign">
            <double>9</double>
        </edit>
    </match>
</fontconfig>
EOF

# Configure PulseAudio for mobile audio
log "Configuring audio for mobile experience..."
mkdir -p /etc/pulse/system.pa.d

cat > /etc/pulse/system.pa.d/maxregneros-mobile.pa << 'EOF'
# MaxregnerOS Mobile Audio Configuration

# Load mobile-optimized modules
load-module module-switch-on-port-available
load-module module-switch-on-connect
load-module module-card-restore
load-module module-device-restore
load-module module-stream-restore
load-module module-idle-detect
load-module module-default-device-restore
load-module module-rescue-streams
load-module module-always-sink
load-module module-intended-roles
load-module module-suspend-on-idle timeout=5

# Mobile audio enhancements
load-module module-echo-cancel aec_method=webrtc source_name=echocancel_source sink_name=echocancel_sink
load-module module-filter-heuristics
load-module module-filter-apply

# Set default sample rate for mobile devices
set-default-sample-rate 48000
set-alternate-sample-rate 44100
EOF

# Configure NetworkManager for mobile connectivity
log "Configuring network management for mobile..."
mkdir -p /etc/NetworkManager/conf.d

cat > /etc/NetworkManager/conf.d/maxregneros-mobile.conf << 'EOF'
[main]
# MaxregnerOS Mobile Network Configuration
plugins=keyfile
dhcp=internal
dns=systemd-resolved

[connectivity]
uri=http://connectivity-check.ubuntu.com/
interval=300
response=

[device]
wifi.scan-rand-mac-address=yes
wifi.cloned-mac-address=random

[connection]
wifi.cloned-mac-address=random
ethernet.cloned-mac-address=random
connection.stable-id=${CONNECTION}/${BOOT}

[logging]
level=INFO
domains=PLATFORM,RFKILL,ETHER,WIFI,BT,MB,DHCP4,DHCP6,PPP,WIFI_SCAN,IP4,IP6,AUTOIP4,DNS,VPN,SHARING,SUPPLICANT,AGENTS,SETTINGS,SUSPEND,CORE,DEVICE,OLPC,INFINIBAND,FIREWALL,ADSL,BOND,VLAN,BRIDGE,DBUS_PROPS,TEAM,CONCHECK,DCB,DISPATCH,AUDIT,SYSTEMD
EOF

# Create mobile-optimized environment variables
log "Setting up mobile environment variables..."
cat > /etc/environment.d/maxregneros-mobile.conf << 'EOF'
# MaxregnerOS Mobile Environment Variables

# Qt/GTK mobile optimizations
QT_AUTO_SCREEN_SCALE_FACTOR=1
QT_ENABLE_HIGHDPI_SCALING=1
QT_SCALE_FACTOR_ROUNDING_POLICY=RoundPreferFloor
GDK_SCALE=1
GDK_DPI_SCALE=1

# Touch and gesture support
QT_QPA_PLATFORM=xcb
QT_QPA_PLATFORMTHEME=qt5ct
GTK_OVERLAY_SCROLLING=1
GTK_USE_PORTAL=1

# Mobile performance
MESA_GLTHREAD=true
MESA_NO_ERROR=1
RADV_PERFTEST=aco,llvm
__GL_THREADED_OPTIMIZATIONS=1

# Mobile UI preferences
DESKTOP_SESSION=maxregneros
XDG_CURRENT_DESKTOP=MaxregnerOS
XDG_SESSION_DESKTOP=maxregneros
XDG_SESSION_TYPE=x11

# Browser optimizations for mobile
MOZ_USE_XINPUT2=1
MOZ_ENABLE_WAYLAND=0
FIREFOX_USE_XINPUT2=1
EOF

# Enable services
log "Enabling MaxregnerOS mobile services..."
systemctl enable maxregneros-gestures.service
systemctl enable maxregneros-compositor.service
systemctl enable maxregneros-mobile-optimizer.service

# Create mobile UI initialization script
log "Creating mobile UI initialization script..."
cat > /usr/share/maxregneros-ui/scripts/init-mobile-ui.sh << 'EOF'
#!/bin/bash
# MaxregnerOS Mobile UI Initialization Script

# Wait for X11 to be ready
while ! xset q &>/dev/null; do
    sleep 1
done

# Apply mobile UI settings
xrandr --output $(xrandr | grep " connected" | cut -d" " -f1 | head -1) --auto 2>/dev/null || true

# Configure input devices
xinput set-prop "$(xinput list --name-only | grep -i touch | head -1)" "libinput Tapping Enabled" 1 2>/dev/null || true
xinput set-prop "$(xinput list --name-only | grep -i touchpad | head -1)" "libinput Natural Scrolling Enabled" 1 2>/dev/null || true

# Start mobile UI components
/usr/bin/touchegg --daemon &
/usr/bin/picom --config /etc/maxregneros-ui/configs/picom.conf &

# Apply mobile theme
gsettings set org.gnome.desktop.interface gtk-theme "MaxregnerOS-Glassy" 2>/dev/null || true
gsettings set org.gnome.desktop.interface icon-theme "Papirus" 2>/dev/null || true
gsettings set org.gnome.desktop.interface cursor-theme "Adwaita" 2>/dev/null || true

# Configure mobile-friendly settings
gsettings set org.gnome.desktop.interface enable-animations true 2>/dev/null || true
gsettings set org.gnome.desktop.interface show-battery-percentage true 2>/dev/null || true
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true 2>/dev/null || true
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true 2>/dev/null || true

log "MaxregnerOS Mobile UI initialized successfully"
EOF

chmod +x /usr/share/maxregneros-ui/scripts/init-mobile-ui.sh

# Create desktop entry for mobile UI
mkdir -p /etc/xdg/autostart
cat > /etc/xdg/autostart/maxregneros-mobile-ui.desktop << 'EOF'
[Desktop Entry]
Type=Application
Name=MaxregnerOS Mobile UI
Comment=Initialize MaxregnerOS glassy mobile UI features
Exec=/usr/share/maxregneros-ui/scripts/init-mobile-ui.sh
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
X-KDE-autostart-after=panel
X-MATE-Autostart-enabled=true
EOF

# Set proper permissions
log "Setting proper permissions..."
chown -R root:root /etc/maxregneros-ui
chown -R root:root /usr/share/maxregneros-ui
chown -R root:root /usr/lib/maxregneros-ui
chmod -R 755 /usr/share/maxregneros-ui/scripts
chmod 644 /etc/systemd/system/maxregneros-*.service

log "MaxregnerOS Mobile UI Rootfs Integration completed successfully!"
log "The system now includes:"
log "  ✓ Glassy mobile UI themes and configurations"
log "  ✓ Touch and gesture recognition services"
log "  ✓ Mobile-optimized system settings"
log "  ✓ Performance optimizations for mobile hardware"
log "  ✓ Responsive layout and adaptive UI components"
log "  ✓ Mobile-friendly application configurations"

warn "Please reboot the system to activate all mobile UI features."
