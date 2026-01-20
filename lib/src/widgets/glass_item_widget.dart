import 'package:flutter/material.dart';
import '../glass_nav_item.dart';

/// A widget representing a single item in the [CustomGlassNavBar].
class GlassItemWidget extends StatelessWidget {
  /// The item data.
  final GlassNavItem item;

  /// Whether this item is currently selected.
  final bool isSelected;

  /// Callback when the item is tapped.
  final VoidCallback onTap;

  /// Color of the icon when inactive.
  final Color iconColor;

  /// Color of the icon when active.
  final Color activeIconColor;

  /// Creates a [GlassItemWidget].
  const GlassItemWidget({
    Key? key,
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.iconColor,
    required this.activeIconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: isSelected ? 1.2 : 1.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutBack,
                child: Icon(
                  item.icon,
                  color: isSelected ? activeIconColor : iconColor,
                ),
              ),
              if (item.label != null && isSelected) ...[
                const SizedBox(height: 4),
                Text(
                  item.label!,
                  style: TextStyle(
                    color: activeIconColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
