import 'package:flutter/widgets.dart';

/// A data model representing a single navigation item in [CustomGlassNavBar].
class GlassNavItem {
  /// The icon to display for this item.
  final IconData icon;

  /// Optional label for the item.
  final String? label;

  /// Creates a [GlassNavItem].
  const GlassNavItem({
    required this.icon,
    this.label,
  });
}
