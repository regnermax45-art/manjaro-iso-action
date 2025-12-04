# MaxregnerOS UI - Complete Guide

## 🌟 Introduction

MaxregnerOS UI is a revolutionary glassy mobile-first interface system that transforms traditional Linux desktop environments into modern, touch-friendly, mobile-optimized experiences. Built on top of Manjaro Linux, it provides a comprehensive suite of mobile UI features while maintaining full desktop functionality.

## 🎯 Key Features

### 🔮 Glassy Transparency Effects
- **Backdrop Blur**: 15px blur radius with hardware acceleration
- **Transparency Layers**: 85% opacity for depth and visual hierarchy
- **Glass Borders**: Subtle borders with glass-like reflections
- **Dynamic Shadows**: Multi-layer shadow system for realistic depth

### 📱 Mobile-First Design
- **Touch Targets**: Minimum 44px touch targets throughout the interface
- **Responsive Layouts**: Adaptive interfaces that scale to any screen size
- **Mobile Typography**: Optimized font sizes and spacing for readability
- **Touch-Friendly Controls**: Large buttons, sliders, and interactive elements

### 👆 Advanced Gesture Support
- **Multi-Touch Recognition**: Support for 2-10 finger gestures
- **Edge Swipes**: Mobile-like navigation from screen edges
- **Pinch & Zoom**: Natural scaling in applications and system UI
- **Gesture Customization**: Fully configurable gesture mappings

### 🎨 Theme System
- **Multiple Variants**: Glassy, Crystal, Aurora, and Neon themes
- **Dynamic Colors**: Material Design color palette with glass effects
- **Adaptive Theming**: Automatic light/dark mode switching
- **Custom Themes**: Extensible theme system for custom designs

## 🚀 Getting Started

### System Requirements

**Minimum Requirements:**
- **CPU**: 64-bit processor (x86_64)
- **RAM**: 2GB (4GB recommended)
- **Storage**: 20GB available space
- **GPU**: Any modern GPU with OpenGL 3.0+ support

**Recommended for Full Experience:**
- **RAM**: 4GB or more
- **GPU**: Dedicated graphics card with hardware acceleration
- **Input**: Touch screen or precision touchpad
- **Display**: 1920x1080 or higher resolution

### Building MaxregnerOS ISO

#### Basic Build

```yaml
- name: Build MaxregnerOS ISO
  uses: manjaro/manjaro-iso-action@main
  with:
    edition: maxregneros
    branch: stable
    scope: full
    maxregneros-ui-enabled: true
```

#### Advanced Configuration

```yaml
- name: Build MaxregnerOS ISO with Custom Settings
  uses: manjaro/manjaro-iso-action@main
  with:
    # Basic configuration
    edition: maxregneros
    branch: stable
    scope: full
    version: "24.0"
    kernel: linux66
    code-name: "MaxregnerOS Glassy"
    
    # MaxregnerOS UI settings
    maxregneros-ui-enabled: true
    maxregneros-ui-theme: glassy
    maxregneros-mobile-optimization: true
    maxregneros-responsive-layout: true
    maxregneros-gesture-support: true
    maxregneros-glassy-effects: true
    
    # Distribution settings
    release-tag: "maxregneros-v1.0"
    office-chooser: true
```

## 🎛️ Configuration Options

### Core UI Settings

| Parameter | Description | Default | Options |
|-----------|-------------|---------|---------|
| `maxregneros-ui-enabled` | Enable MaxregnerOS UI features | `false` | `true`, `false` |
| `maxregneros-ui-theme` | Theme variant | `glassy` | `glassy`, `crystal`, `aurora`, `neon` |
| `maxregneros-mobile-optimization` | Mobile performance tuning | `true` | `true`, `false` |
| `maxregneros-responsive-layout` | Responsive layout system | `true` | `true`, `false` |
| `maxregneros-gesture-support` | Gesture recognition | `true` | `true`, `false` |
| `maxregneros-glassy-effects` | Transparency effects | `true` | `true`, `false` |

### Theme Variants

#### Glassy Theme
- **Style**: Classic transparent glass effects
- **Colors**: Blue primary with white glass surfaces
- **Effects**: Medium blur with 85% transparency
- **Best For**: General use, professional environments

#### Crystal Theme
- **Style**: Ice-like crystalline transparency
- **Colors**: Cool blue-white palette with crystal effects
- **Effects**: Sharp edges with high contrast
- **Best For**: Modern, minimalist setups

#### Aurora Theme
- **Style**: Colorful gradient effects
- **Colors**: Dynamic color gradients with aurora-like transitions
- **Effects**: Animated gradients with color shifting
- **Best For**: Creative work, entertainment systems

#### Neon Theme
- **Style**: Vibrant accent colors
- **Colors**: Bright neon accents with dark backgrounds
- **Effects**: Glowing edges and neon highlights
- **Best For**: Gaming, night use, high-contrast needs

## 📱 Mobile Features

### Touch Interface

#### Touch Targets
- **Minimum Size**: 44px × 44px for all interactive elements
- **Comfortable Size**: 48px × 48px for primary actions
- **Large Size**: 56px × 56px for critical functions

#### Touch Feedback
- **Visual Feedback**: Ripple effects on touch
- **Haptic Feedback**: Vibration on supported devices
- **Audio Feedback**: Optional sound effects

### Gesture System

#### Three-Finger Gestures
- **Swipe Up**: Show desktop
- **Swipe Down**: Show desktop (alternative)
- **Swipe Left**: Next workspace
- **Swipe Right**: Previous workspace
- **Tap**: Middle mouse click
- **Pinch In**: Minimize window
- **Pinch Out**: Maximize window

#### Four-Finger Gestures
- **Swipe Up**: Show activities overview
- **Swipe Down**: Show applications
- **Swipe Left**: Switch to next application
- **Swipe Right**: Switch to previous application
- **Tap**: Show context menu
- **Pinch In**: Show desktop
- **Pinch Out**: Show all windows

#### Two-Finger Gestures
- **Scroll**: Natural scrolling in applications
- **Pinch In/Out**: Zoom in applications
- **Tap**: Right-click context menu
- **Double Tap**: Smart zoom

#### Edge Gestures
- **Left Edge → Right**: Browser/app back navigation
- **Right Edge → Left**: Browser/app forward navigation
- **Top Edge → Down**: Show notifications
- **Bottom Edge → Up**: Show dock/taskbar

### Virtual Keyboard

#### Features
- **Auto-Show**: Appears when text input is focused
- **Adaptive Layout**: Adjusts to screen orientation
- **Gesture Typing**: Swipe-to-type support
- **Emoji Support**: Full emoji keyboard
- **Multiple Languages**: Support for international layouts

#### Configuration
```bash
# Enable virtual keyboard
gsettings set org.gnome.desktop.a11y.applications screen-keyboard-enabled true

# Configure auto-show
gsettings set org.gnome.desktop.a11y.applications screen-keyboard-enabled-on-focus true
```

## 🏗️ Architecture

### System Integration Levels

#### 1. ISO Build Level
- Package selection and installation
- Base system configuration
- Theme and asset integration
- Service configuration

#### 2. Rootfs Level
- System-wide settings and policies
- Service definitions and startup scripts
- Hardware optimization configurations
- Security and performance tuning

#### 3. Application Level
- Mobile-optimized application configurations
- Touch-friendly interface adaptations
- Gesture integration in applications
- Responsive layout implementations

#### 4. Theme Level
- Visual styling and effects
- Color schemes and typography
- Animation and transition definitions
- Responsive design breakpoints

### Core Components

#### Compositor (Picom)
- **Purpose**: Handles transparency, blur, and visual effects
- **Configuration**: `/etc/maxregneros-ui/configs/picom.conf`
- **Features**: Hardware-accelerated rendering, blur effects, shadows

#### Gesture Engine (Touchegg)
- **Purpose**: Multi-touch gesture recognition and processing
- **Configuration**: `/etc/maxregneros-ui/configs/touchegg.conf`
- **Features**: Customizable gestures, application-specific mappings

#### Theme Engine
- **GTK3/4**: System-wide theme integration
- **Qt5/6**: Application theme consistency
- **Icon Themes**: Touch-optimized icon sets
- **Cursor Themes**: Large, visible cursors

#### Mobile Services
- **Gesture Service**: `maxregneros-gestures.service`
- **Compositor Service**: `maxregneros-compositor.service`
- **Optimizer Service**: `maxregneros-mobile-optimizer.service`

## 🔧 Customization

### Theme Customization

#### Creating Custom Themes

1. **Create Theme Directory**
```bash
sudo mkdir -p /usr/share/maxregneros-ui/themes/mytheme
```

2. **Define Theme Configuration**
```ini
# /usr/share/maxregneros-ui/themes/mytheme/theme.conf
[Theme_Info]
name = "My Custom Theme"
description = "Custom glassy theme variant"
version = "1.0.0"
author = "Your Name"

[Colors]
primary = "#FF5722"
secondary = "#FFC107"
background = "rgba(255,255,255,0.9)"
# ... more color definitions
```

3. **Apply Custom Theme**
```bash
# Set theme in configuration
echo "UI_THEME=mytheme" | sudo tee -a /etc/maxregneros-ui/config.conf
```

### Gesture Customization

#### Custom Gesture Mappings

```xml
<!-- ~/.config/touchegg/touchegg.conf -->
<touchégg>
  <application name="All">
    <gesture type="SWIPE" direction="UP" fingers="5">
      <action type="RUN_COMMAND">
        <command>my-custom-command</command>
      </action>
    </gesture>
  </application>
</touchégg>
```

#### Application-Specific Gestures

```xml
<application name="firefox">
  <gesture type="SWIPE" direction="LEFT" fingers="2">
    <action type="SEND_KEYS">
      <keys>Alt+Left</keys>
    </action>
  </gesture>
</application>
```

### Performance Tuning

#### GPU Optimization

```bash
# Enable hardware acceleration
export MESA_GLTHREAD=true
export __GL_THREADED_OPTIMIZATIONS=1

# For AMD GPUs
export RADV_PERFTEST=aco,llvm

# For Intel GPUs
export INTEL_DEBUG=perf
```

#### Memory Optimization

```bash
# Adjust swappiness for mobile performance
echo 'vm.swappiness=1' | sudo tee -a /etc/sysctl.conf

# Optimize cache pressure
echo 'vm.vfs_cache_pressure=10' | sudo tee -a /etc/sysctl.conf
```

## 🔍 Troubleshooting

### Common Issues

#### Glassy Effects Not Working

**Symptoms:**
- No transparency or blur effects
- Solid backgrounds instead of glass
- Poor visual quality

**Solutions:**
1. **Check GPU Drivers**
```bash
# Verify GPU driver installation
lspci -k | grep -A 2 -i "VGA\|3D\|Display"

# Install missing drivers
sudo pacman -S mesa vulkan-radeon  # For AMD
sudo pacman -S nvidia nvidia-utils  # For NVIDIA
```

2. **Verify Compositor**
```bash
# Check if picom is running
systemctl --user status maxregneros-compositor

# Restart compositor
systemctl --user restart maxregneros-compositor
```

3. **Hardware Acceleration**
```bash
# Test OpenGL support
glxinfo | grep "direct rendering"

# Should show "direct rendering: Yes"
```

#### Gestures Not Responding

**Symptoms:**
- Touch gestures not recognized
- Inconsistent gesture behavior
- Gestures work in some apps but not others

**Solutions:**
1. **Check Touchegg Service**
```bash
# Verify gesture service
systemctl --user status maxregneros-gestures

# Restart if needed
systemctl --user restart maxregneros-gestures
```

2. **Input Device Configuration**
```bash
# List input devices
xinput list

# Check touchpad/touchscreen properties
xinput list-props "device-name"

# Enable tapping if disabled
xinput set-prop "device-name" "libinput Tapping Enabled" 1
```

3. **Permissions**
```bash
# Add user to input group
sudo usermod -a -G input $USER

# Logout and login again
```

#### Performance Issues

**Symptoms:**
- Slow animations or transitions
- High CPU/GPU usage
- System lag during UI interactions

**Solutions:**
1. **Reduce Visual Effects**
```bash
# Disable some effects temporarily
gsettings set org.gnome.desktop.interface enable-animations false

# Reduce blur radius in picom config
sudo sed -i 's/blur-strength = 8/blur-strength = 4/' /etc/maxregneros-ui/configs/picom.conf
```

2. **Check System Resources**
```bash
# Monitor resource usage
htop
nvidia-smi  # For NVIDIA GPUs
radeontop   # For AMD GPUs
```

3. **Optimize for Older Hardware**
```bash
# Disable transparency for better performance
echo "MAXREGNEROS_GLASSY_EFFECTS=false" | sudo tee -a /etc/environment
```

### Debug Mode

#### Enable Debug Logging

```bash
# Enable debug mode
echo "debug_mode = true" | sudo tee -a /etc/maxregneros-ui/config.conf

# View gesture debug info
echo "gesture_debugging = true" | sudo tee -a /configs/gesture-settings.conf

# Restart services
sudo systemctl restart maxregneros-*
```

#### Log Locations

```bash
# System logs
journalctl -u maxregneros-gestures
journalctl -u maxregneros-compositor

# User logs
~/.local/share/maxregneros-ui/logs/

# X11 logs
~/.local/share/xorg/Xorg.0.log
```

## 🤝 Contributing

### Development Setup

1. **Clone Repository**
```bash
git clone https://github.com/regnermax45-art/manjaro-iso-action.git
cd manjaro-iso-action
```

2. **Create Development Branch**
```bash
git checkout -b feature/my-maxregneros-feature
```

3. **Test Changes**
```bash
# Build test ISO
.github/workflows/test.yml
```

### Contribution Guidelines

#### Theme Development
- Follow existing theme structure in `/themes/glassy-mobile/`
- Maintain accessibility standards (WCAG 2.1 AA)
- Test on multiple screen sizes and input methods
- Document color choices and design decisions

#### Gesture Development
- Test gestures on real hardware when possible
- Consider accessibility and alternative input methods
- Document gesture mappings clearly
- Avoid conflicts with existing system gestures

#### Performance Optimization
- Profile changes with real-world usage
- Test on various hardware configurations
- Document performance impact
- Provide fallback options for older hardware

### Code Style

#### Shell Scripts
```bash
#!/bin/bash
# Use strict error handling
set -euo pipefail

# Clear variable naming
readonly MAXREGNEROS_CONFIG_DIR="/etc/maxregneros-ui"

# Proper error handling
if [[ ! -d "$MAXREGNEROS_CONFIG_DIR" ]]; then
    echo "Error: Configuration directory not found" >&2
    exit 1
fi
```

#### Configuration Files
```ini
# Use clear section headers
[Section_Name]

# Document complex settings
# This setting controls the blur radius for glassy effects
blur_radius = 15

# Use consistent naming
maxregneros_setting_name = value
```

## 📚 Resources

### Documentation
- [MaxregnerOS UI GitHub Repository](https://github.com/regnermax45-art/manjaro-iso-action)
- [Manjaro ISO Profiles](https://gitlab.manjaro.org/profiles-and-settings/iso-profiles)
- [Touchegg Documentation](https://github.com/JoseExposito/touchegg)
- [Picom Configuration](https://github.com/yshui/picom)

### Community
- [MaxregnerOS Community Forum](https://forum.maxregneros.org)
- [GitHub Discussions](https://github.com/regnermax45-art/manjaro-iso-action/discussions)
- [Discord Server](https://discord.gg/maxregneros)

### Support
- [Issue Tracker](https://github.com/regnermax45-art/manjaro-iso-action/issues)
- [Feature Requests](https://github.com/regnermax45-art/manjaro-iso-action/issues/new?template=feature_request.md)
- [Bug Reports](https://github.com/regnermax45-art/manjaro-iso-action/issues/new?template=bug_report.md)

## 📄 License

MaxregnerOS UI is released under the GPL-3.0 license, ensuring compatibility with the underlying Manjaro and Linux ecosystem while maintaining open-source principles.

---

*MaxregnerOS UI - Bringing the future of mobile interfaces to Linux desktop environments.*
