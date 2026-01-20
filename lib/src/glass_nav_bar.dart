import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'glass_nav_item.dart';
import 'painters/bubble_painter.dart';
import 'widgets/glass_item_widget.dart';

/// A Custom Bottom Navigation Bar with Glassmorphism and Liquid Animation.
class CustomGlassNavBar extends StatefulWidget {
  /// The list of items to display.
  final List<GlassNavItem> items;

  /// The index of the currently selected item.
  final int currentIndex;

  /// Callback when an item is tapped.
  final Function(int) onTap;

  /// Background color of the bar. It should be semi-transparent for the glass effect.
  final Color backgroundColor;

  /// Color of the liquid bubble indicator.
  final Color bubbleColor;

  /// Optional gradient for the bubble.
  final Gradient? bubbleGradient;

  /// Color of the icons when inactive.
  final Color iconColor;

  /// Color of the icons when active.
  final Color activeIconColor;

  /// Height of the navigation bar.
  final double height;

  /// Strength of the blur effect.
  final double blurStrength;

  /// Border radius of the navigation bar.
  final double borderRadius;

  /// Whether dragging is enabled (if applicable for future sliding gestures).
  final bool enableDrag;

  /// Duration of the slide animation.
  final Duration animationDuration;

  /// Creates a [CustomGlassNavBar].
  const CustomGlassNavBar({
    Key? key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.backgroundColor = const Color(0x33FFFFFF), // Semi-transparent white
    this.bubbleColor = const Color(0x33FFFFFF), // Neutral glass white
    this.bubbleGradient,
    this.iconColor = Colors.white70,
    this.activeIconColor = Colors.white,
    this.height = 70.0,
    this.blurStrength = 10.0,
    this.borderRadius = 20.0,
    this.enableDrag = false,
    this.animationDuration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  State<CustomGlassNavBar> createState() => _CustomGlassNavBarState();
}

class _CustomGlassNavBarState extends State<CustomGlassNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  int _previousIndex = 0;

  @override
  void initState() {
    super.initState();
    _previousIndex = widget.currentIndex;
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _previousIndex = widget.currentIndex;
        });
      }
    });
  }

  @override
  void didUpdateWidget(CustomGlassNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex != oldWidget.currentIndex) {
      _startAnimation(oldWidget.currentIndex, widget.currentIndex);
    }
  }

  void _startAnimation(int fromIndex, int toIndex) {
    // Only update previous index if we are not already animating from it
    // This handles rapid taps better
    if (!_controller.isAnimating) {
      _previousIndex = fromIndex;
    } else {
      // If already animating, we are at some intermediate point.
      // Ideally we start from current visual position, but for simplicity
      // and stability, snapping _previousIndex to the current known 'from'
      // is acceptable or let it finish.
      // For now, let's trust the fromIndex passed by parent which is the 'old' index.
      _previousIndex = fromIndex;
    }

    _controller.reset();
    _controller.forward();
    if (widget.items.length > fromIndex && widget.items.length > toIndex) {
      HapticFeedback.lightImpact();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = constraints.maxWidth / widget.items.length;

        // Calculate the current offset of the bubble based on animation
        final double startOffset = _previousIndex * itemWidth;
        final double endOffset = widget.currentIndex * itemWidth;

        return ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: widget.blurStrength,
              sigmaY: widget.blurStrength,
            ),
            child: Container(
              height: widget.height,
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(widget.borderRadius),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // The Liquid Bubble
                  RepaintBoundary(
                    child: AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          // Interpolate offset manually or simply pass animation value to painter
                          // passing animation value is cleaner if painter handles start/end,
                          // but here we calculate the exact visual offset for the painter.
                          final double currentOffset = startOffset +
                              (endOffset - startOffset) * _animation.value;

                          return CustomPaint(
                            size: Size(constraints.maxWidth, widget.height),
                            painter: BubblePainter(
                              bubbleColor: widget.bubbleColor,
                              animationValue: _animation.value,
                              offset: currentOffset -
                                  (constraints.maxWidth / 2) +
                                  (itemWidth / 2),
                              radius: widget
                                      .items[widget.currentIndex].circleSize ??
                                  (itemWidth * 0.5).clamp(0.0, 25.0),
                              bubbleGradient: widget.bubbleGradient,
                            ),
                          );
                        }),
                  ),

                  // The Items
                  Row(
                    children: widget.items.asMap().entries.map((entry) {
                      final int index = entry.key;
                      final GlassNavItem item = entry.value;

                      return GlassItemWidget(
                        item: item,
                        isSelected: index == widget.currentIndex,
                        onTap: () => widget.onTap(index),
                        iconColor: widget.iconColor,
                        activeIconColor: widget.activeIconColor,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
