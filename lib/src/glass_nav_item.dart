import 'package:flutter/widgets.dart';

/// A data model representing a single navigation item in [CustomGlassNavBar].
class GlassNavItem {
  /// The icon to display for this item.
  /// Can be an [IconData] or a [Widget].
  final dynamic icon;

  /// Optional label for the item.
  final String? label;

  /// Optional scalar for the liquid bubble radius when this item is active.
  /// If provided, this overrides the default dynamic calculation.
  final double? circleSize;

  /// Creates a [GlassNavItem].
  const GlassNavItem({
    required this.icon,
    this.label,
    this.circleSize,
  }) : assert(icon is IconData || icon is Widget,
            'icon must be of type IconData or Widget');
}
