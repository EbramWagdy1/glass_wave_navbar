import 'package:flutter/material.dart';
import 'package:glass_wave_navbar/glass_wave_navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glass Wave Navbar Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<GlassNavItem> _items = [
    const GlassNavItem(icon: Icons.home, label: 'Home'),
    const GlassNavItem(icon: Icons.search, label: 'Search'),
    const GlassNavItem(icon: Icons.favorite, label: 'Likes'),
    const GlassNavItem(icon: Icons.person, label: 'Profile'),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Direct navigation: no scroll animation for intermediate pages
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Important for glass effect to show content behind
      body: Stack(
        children: [
          // Background Image/Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 74, 73, 78),
                  Color.fromARGB(255, 64, 71, 71)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return _buildPage(
                    _items[index].label ?? 'Item', _items[index].icon);
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 90.0), // Margin above navbar
        child: FloatingActionButton(
          onPressed: () {
            if (_items.length < 8) {
              setState(() {
                _items.add(
                    _availableIcons[_items.length % _availableIcons.length]);
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Max items reached (8) for demo')),
              );
            }
          },
          backgroundColor: Colors.white.withValues(alpha: 0.2),
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: Colors.white.withValues(alpha: 0.3))),
          child: const Icon(Icons.add, color: Colors.white),
          tooltip: 'Add Item',
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomGlassNavBar(
          items: _items,
          currentIndex: _currentIndex.clamp(0, _items.length - 1),
          onTap: _onTap,
          backgroundColor: Colors.white.withValues(alpha: 0.05),
          bubbleGradient: LinearGradient(
            colors: [
              Colors.white.withValues(alpha: 0.6),
              Colors.white.withValues(alpha: 0.2)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          itemBubbleRadius: 35,
          activeIconColor: Colors.white,
          iconColor: Colors.white38,
          blurStrength: 20,
          borderRadius: 25,
          height: 80,
        ),
      ),
    );
  }

  // Pre-defined list of distinct icons for demo
  final List<GlassNavItem> _availableIcons = const [
    GlassNavItem(icon: Icons.home_rounded, label: 'Home', circleSize: 35.0),
    GlassNavItem(icon: Icons.search_rounded, label: 'Search', circleSize: 35.0),
    GlassNavItem(
        icon: Icons.favorite_rounded, label: 'Likes', circleSize: 35.0),
    GlassNavItem(
        icon: Icons.person_rounded, label: 'Profile', circleSize: 35.0),
    GlassNavItem(
        icon: Icons.settings_rounded, label: 'Settings', circleSize: 35.0),
    GlassNavItem(
        icon: Icons.shopping_cart_rounded, label: 'Cart', circleSize: 35.0),
    GlassNavItem(
        icon: Icons.notifications_rounded, label: 'Notify', circleSize: 35.0),
    GlassNavItem(
        icon: Icons.chat_bubble_rounded, label: 'Chat', circleSize: 35.0),
  ];

  Widget _buildPage(String title, dynamic icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    spreadRadius: 5,
                  )
                ]),
            child: icon is Widget
                ? icon
                : Icon(icon,
                    size: 80, color: Colors.white.withValues(alpha: 0.9)),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                    color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
