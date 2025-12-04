# manjaro-iso-action

Tooling to build and distribute Manjaro on via Github Actions

## Usage example

This action ...

- installs the prerequisites to build Manjaro
- builds a ready to go Manjaro iso
- calculates hashes for the resulting image

It optionally provides:

- GPG-signing
- Distribution to: Github Releases, CDN77, OSDN, SourceForge

The following example is a minimal "matrix strategy" setup, that builds minimal and full images for cinnamon, gnome and builds the images each on stable and testing repositories. Refer [here](https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idstrategymatrix) for more information on including / excluding permutations from matrix strategies.

All configuration options and defaults can be found [here](action.yml).

Instead of `manjaro/manjaro-iso-action@main`, please refer to the most current release (e.g. `manjaro/manjaro-iso-action@v1`).

```yaml
name: iso_build
on:
  workflow_dispatch:
  # remove if you don't want to build on a schedule
  schedule:
    - cron:  '30 6 1 * *'
  # remove if you don't want to build when commits are pushed to you main/master branch
  push:
    branches:
      - master
      - main

jobs:
  prepare-release:
    runs-on: ubuntu-20.04
    steps:
      # cancel already running instances of the same action on the currently working on branch
      - uses: styfle/cancel-workflow-action@0.9.0
        with:
          access_token: ${{ github.token }}
      - id: time
        uses: nanzm/get-time-action@v1.1
        with:
          format: 'YYYYMMDDHHmm'
    outputs:
      # generate a common tag to be used in all elements of the matrix strategy
      release_tag: ${{ steps.time.outputs.time }}      
  release:
    runs-on: ubuntu-20.04
    needs: prepare-release    
    strategy:
      matrix:
        ##### EDIT ME #####      
        EDITION: [cinnamon, gnome, maxregneros]
        BRANCH: [stable, testing]
        SCOPE: [minimal,full]
        ###################
    steps:
      # cancel already running instances of the same action on the currently working on branch
      - uses: styfle/cancel-workflow-action@0.9.0
        with:
          access_token: ${{ github.token }}
      - id: image-build
        uses: manjaro/manjaro-iso-action@main
        with:
          edition: ${{ matrix.edition }}
          branch: ${{ matrix.branch }}
          scope: ${{ matrix.scope }}
          version: "21.0"
          kernel: linux510
          code-name: "Ornara"
          # providing a release-tag allows for github releases
          release-tag: ${{ needs.prepare-release.outputs.release_tag }}
      # delete the github release in case of cancellation or failure
      # refer to .github/workflows/cleanup-test-release.yml for rollback strategies concerning the other distribution channels
      - name: rollback github release
        if: ${{ failure() || cancelled() }}
        run: |
          echo ${{ github.token }} | gh auth login --with-token
          gh release delete ${{ needs.prepare-release.outputs.release_tag }} -y --repo ${{ github.repository }}
          git push --delete origin ${{ needs.prepare-release.outputs.release_tag }}

## MaxregnerOS UI - Glassy Mobile Features

This action now supports **MaxregnerOS UI**, a revolutionary glassy mobile-first interface that transforms traditional Linux desktop environments into modern, touch-friendly, mobile-optimized experiences.

### 🌟 MaxregnerOS UI Features

- **🔮 Glassy Transparency Effects**: Beautiful blur and transparency effects throughout the interface
- **📱 Mobile-First Design**: Touch-optimized controls and mobile-friendly layouts
- **👆 Advanced Gesture Support**: Comprehensive multi-touch gesture recognition
- **🎨 Responsive Layouts**: Adaptive interfaces that work on any screen size
- **⚡ Performance Optimized**: Hardware-accelerated rendering and mobile performance tuning
- **🎯 Touch-Friendly**: 44px minimum touch targets and haptic feedback
- **🌈 Modern Aesthetics**: Material Design-inspired with glassy visual effects

### 🚀 Using MaxregnerOS Edition

To build a MaxregnerOS ISO with glassy mobile UI features:

```yaml
- id: image-build
  uses: manjaro/manjaro-iso-action@main
  with:
    edition: maxregneros
    branch: stable
    scope: full
    # MaxregnerOS UI Configuration
    maxregneros-ui-enabled: true
    maxregneros-ui-theme: glassy
    maxregneros-mobile-optimization: true
    maxregneros-responsive-layout: true
    maxregneros-gesture-support: true
    maxregneros-glassy-effects: true
```

### 🎛️ MaxregnerOS UI Configuration Options

| Parameter | Description | Default | Options |
|-----------|-------------|---------|---------|
| `maxregneros-ui-enabled` | Enable MaxregnerOS glassy mobile UI features | `false` | `true`, `false` |
| `maxregneros-ui-theme` | UI theme variant | `glassy` | `glassy`, `crystal`, `aurora`, `neon` |
| `maxregneros-mobile-optimization` | Enable mobile-first optimizations | `true` | `true`, `false` |
| `maxregneros-responsive-layout` | Enable responsive layout system | `true` | `true`, `false` |
| `maxregneros-gesture-support` | Enable gesture recognition | `true` | `true`, `false` |
| `maxregneros-glassy-effects` | Enable transparency effects | `true` | `true`, `false` |

### 📱 Mobile UI Components

#### Glassy Theme System
- **Transparency**: 85% opacity with 15px blur radius
- **Corner Radius**: 12px rounded corners throughout
- **Shadows**: Multi-layer shadow system for depth
- **Colors**: Material Design color palette with glass effects

#### Touch & Gesture Support
- **3-finger gestures**: Workspace switching and desktop management
- **4-finger gestures**: Application switching and overview
- **2-finger gestures**: Scrolling, zooming, and navigation
- **Edge swipes**: Mobile-like navigation from screen edges
- **Pinch & zoom**: Natural scaling and interaction

#### Mobile-Optimized Applications
- **Firefox**: Touch-friendly interface with mobile gestures
- **File Manager**: Large touch targets and swipe navigation
- **System Settings**: Mobile-first configuration panels
- **Virtual Keyboard**: On-screen keyboard for touch devices

### 🏗️ Architecture Overview

MaxregnerOS UI integrates at multiple system levels:

1. **ISO Build Level**: Packages and configurations embedded during build
2. **Rootfs Level**: System-wide settings and services
3. **Application Level**: Mobile-optimized app configurations
4. **Theme Level**: Glassy visual effects and responsive layouts

### 🔧 Advanced Configuration

#### Custom Theme Variants

```yaml
# Crystal theme with ice-like effects
maxregneros-ui-theme: crystal

# Aurora theme with colorful gradients  
maxregneros-ui-theme: aurora

# Neon theme with vibrant accents
maxregneros-ui-theme: neon
```

#### Performance Tuning

```yaml
# Enable all mobile optimizations
maxregneros-mobile-optimization: true
maxregneros-responsive-layout: true
maxregneros-gesture-support: true
maxregneros-glassy-effects: true
```

### 🎯 Use Cases

- **Tablet Devices**: Perfect for convertible laptops and tablets
- **Touch Displays**: Optimized for touch-enabled monitors
- **Mobile Workstations**: Modern interface for portable computing
- **Kiosk Systems**: Touch-friendly public interfaces
- **Educational Devices**: Intuitive interface for learning environments

### 🛠️ Technical Details

#### System Requirements
- **GPU**: Hardware acceleration recommended for glassy effects
- **RAM**: Minimum 2GB, 4GB recommended for full features
- **Storage**: Additional 500MB for UI components and themes
- **Input**: Touch screen or precision touchpad recommended

#### Included Packages
- **Compositor**: Picom with blur and transparency support
- **Gesture Engine**: Touchegg for multi-touch recognition
- **Theme Engine**: GTK3/4 and Qt5/6 theme integration
- **Mobile Apps**: Touch-optimized application suite

### 🔍 Troubleshooting

#### Common Issues

**Glassy effects not working:**
- Ensure GPU drivers support hardware acceleration
- Check if compositor is running: `systemctl status maxregneros-compositor`

**Gestures not responding:**
- Verify touchegg service: `systemctl status maxregneros-gestures`
- Check input device permissions and libinput configuration

**Performance issues:**
- Disable some visual effects for older hardware
- Adjust blur radius and transparency levels in theme configuration

### 🤝 Contributing

MaxregnerOS UI is designed to be extensible and customizable. Contributions are welcome for:

- New theme variants and visual effects
- Additional gesture patterns and touch interactions
- Mobile-optimized application configurations
- Performance improvements and optimizations

### 📄 License

MaxregnerOS UI components are released under GPL-3.0 license, maintaining compatibility with the underlying Manjaro and Linux ecosystem.
```

### gpg signing

```yaml
- id: image-build
  uses: manjaro/manjaro-iso-action@main
  with:
    ...
    gpg-secret-key-base64: ${{ secrets.gpg_secret_base64 }}
    gpg-passphrase: ${{ secrets.GPG_PASSPHRASE }}
```

### caching

to get an idea how caching might work, please refer [here](.github/workflows/test.yml)

## Distribution channels

all distribution channels can be configured by setting / leaving out of their configuration variables.

### github release

```yaml
- id: image-build
  uses: manjaro/manjaro-iso-action@main
  with:
    ...
    release-tag: ${{ needs.prepare-release.outputs.release_tag }}
- name: rollback github release
  if: ${{ failure() || cancelled() }}
  run: |
    echo ${{ github.token }} | gh auth login --with-token
    gh release delete ${{ needs.prepare-release.outputs.release_tag }} -y --repo ${{ github.repository }}
    git push --delete origin ${{ needs.prepare-release.outputs.release_tag }}
```

### cdn77 release

```yaml
- id: image-build
  uses: manjaro/manjaro-iso-action@main
  with:
    ...
    cdn77-host: ${{ secrets.CDN_HOST }}
    cdn77-user: ${{ secrets.CDN_USER }}
    cdn77-pwd: ${{ secrets.CDN_PWD }}
- name: rollback cdn77 upload
  if: ${{ failure() || cancelled() }}
  run: |
    sshpass -p "${{ secrets.CDN_PWD }}" rsync --delete -vaP --stats \
        -e ssh $(mktemp) ${{ secrets.CDN_USER }}@${{ secrets.CDN_HOST }}:/www/${{ env.edition }}/${{ env.version }}
```

### SourceForge release

```yaml
- id: image-build
  uses: manjaro/manjaro-iso-action@main
  with:
    ...
    sf-project: manjarolinux
    sf-user: ${{ secrets.SF_USER_NAME }}
    sf-key: ${{ secrets.SF_PRIV_SSHKEY }}
- name: rollback sourceforge upload
  if: ${{ failure() || cancelled() }}
  env:
    SSH_AUTH_SOCK: /tmp/ssh_agent.sock
  run: |
    rsync --delete -vaP --stats \
        -e ssh $(mktemp) ${{ secrets.SF_USER_NAME }}@frs.sourceforge.net:/home/frs/project/manjarolinux/${{ env.edition }}/${{ env.version }}
```

### osdn release

```yaml
- id: image-build
  uses: manjaro/manjaro-iso-action@main
  with:
    ...
    osdn-project: manjaro
    osdn-user: ${{ secrets.OSDN_USER_NAME }}
    osdn-key: ${{ secrets.OSDN_PRIV_SSHKEY }}
- name: rollback osdn upload
  if: ${{ failure() || cancelled() }}
  env:
    SSH_AUTH_SOCK: /tmp/ssh_agent.sock
  run: |
    rsync --delete -vaP --stats \
        -e ssh $(mktemp) ${{ secrets.OSDN_USER_NAME }}@storage.osdn.net:/storage/groups/m/ma/manjaro/${{ env.edition }}/${{ env.version }}
```
