# Glass Wave Navbar

A production-ready Flutter package that provides a highly customizable navigation bar with a stunning glassmorphism effect and liquid-like bubble animations.


[![Pub Version](https://img.shields.io/pub/v/glass_wave_navbar?color=blue)](https://pub.dev/packages/glass_wave_navbar)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A **production-ready** Flutter package that provides a highly customizable navigation bar with a stunning glasmorphism effect and liquid-like bubble animations.

![Glass Wave Navbar Demo](https://github.com/EbramWagdy1/glass_wave_navbar/raw/main/assets/image.png)

### 🎥 [Watch Demo Video](https://github.com/EbramWagdy1/glass_wave_navbar/raw/main/assets/Testvideo.mp4)

*(Note: Click the link above to watch the liquid animation in action)*


## Features

- 🧊 **Glassmorphism UI**: Built-in support for blur, transparency, and gradients.
- 💧 **Liquid Bubble Animation**: Smoothly animating bubble indicator behind the active tab.
- 🎨 **Fully Customizable**: Control colors, height, blur strength, border radius, and more.
- 📱 **Responsive**: Works great on Mobile, Tablet, and Web.
- ⚡ **Performance Optimized**: Uses efficient CustomPainters and Animations.
- 👆 **Interactive**: Supports tap interactions with haptic feedback potential.

## Installation

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  glass_wave_navbar:
    path: ./ # Or git url / pub version
```

## Usage

Import the package:

```dart
import 'package:glass_wave_navbar/glass_wave_navbar.dart';
```

Use `CustomGlassNavBar` in your `Scaffold`'s `bottomNavigationBar` or anywhere in your UI stack (ensure `extendBody: true` in Scaffold to see content behind the glass).

```dart
Scaffold(
  extendBody: true, // Recommended for glass effect
  body: Container(color: Colors.blueAccent), // Your content
  bottomNavigationBar: CustomGlassNavBar(
    currentIndex: _currentIndex,
    onTap: (index) {
      setState(() {
        _currentIndex = index;
      });
    },
    items: [
      GlassNavItem(icon: Icons.home, label: 'Home'),
      GlassNavItem(icon: Icons.search, label: 'Search'),
      GlassNavItem(icon: Icons.settings, label: 'Settings'),
    ],
  ),
)
```

## Customization

| Parameter | Type | Default | Description |
|---|---|---|---|
| `items` | `List<GlassNavItem>` | Required | List of navigation items. |
| `currentIndex` | `int` | Required | Currently active index. |
| `onTap` | `Function(int)` | Required | Callback when an item is tapped. |
| `backgroundColor` | `Color` | `Colors.white30` | Background color of the bar. |
| `bubbleColor` | `Color` | `Colors.blueAccent` | Color of the animated bubble. |
| `iconColor` | `Color` | `Colors.white70` | Icon color when inactive. |
| `activeIconColor`| `Color` | `Colors.white` | Icon color when active. |
| `height` | `double` | `70.0` | Height of the navbar. |
| `blurStrength` | `double` | `10.0` | Intensity of the glass blur. |
| `borderRadius` | `double` | `20.0` | Corner radius of the container. |
| `itemBubbleRadius` | `double?` | `null` | Explicit radius for the bubble. |
| `animationDuration` | `Duration` | `300ms` | Speed of the selection animation. |

## Example

Check out the `example/` folder for a complete demo application.

## License

MIT
