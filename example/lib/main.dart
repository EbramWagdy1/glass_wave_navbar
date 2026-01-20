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
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
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
                colors: [Color(0xFF6E45E2), Color(0xFF88D3CE)],
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_items.length < 7) {
            setState(() {
              _items.add(GlassNavItem(
                icon: Icons.star_border,
                label: 'Item ${_items.length + 1}',
              ));
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Max items reached (7) for demo')),
            );
          }
        },
        child: const Icon(Icons.add),
        tooltip: 'Add Item',
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomGlassNavBar(
          items: _items,
          currentIndex: _currentIndex.clamp(0, _items.length - 1),
          onTap: _onTap,
          backgroundColor: Colors.white.withOpacity(0.1),
          bubbleColor: Colors.white.withOpacity(0.3),
          activeIconColor: Colors.white,
          iconColor: Colors.white60,
          blurStrength: 15,
          borderRadius: 25,
          height: 75,
        ),
      ),
    );
  }

  Widget _buildPage(String title, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: Colors.white.withOpacity(0.8)),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
