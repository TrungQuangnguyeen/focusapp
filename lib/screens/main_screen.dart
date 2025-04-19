import 'package:flutter/material.dart';
import 'home/home_screen.dart';
import 'blocked_apps/blocked_app_screen.dart';
import 'time_management/time_management_screen.dart';
import 'focus_mode/focus_mode_screen.dart';
import 'settings/settings_screen.dart';

class MainScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final VoidCallback onLogout;

  const MainScreen({super.key, required this.onThemeChanged, required this.onLogout});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  bool _isDarkMode = false;

  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _updateScreens();
  }

  void _updateScreens() {
    _screens.clear();
    _screens.addAll([
      const HomeScreen(),
      const BlockedAppScreen(),
      const TimeManagementScreen(),
      const FocusModeScreen(),
      SettingsScreen(isDarkMode: _isDarkMode, onThemeChanged: _toggleTheme, onLogout: widget.onLogout),
    ]);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
      widget.onThemeChanged(_isDarkMode);
      _updateScreens();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        elevation: 8,
        shadowColor: const Color.fromARGB(66, 53, 53, 53),
        height: 65,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
              color: isDark ? const Color.fromARGB(255, 71, 71, 71) : const Color.fromARGB(255, 98, 102, 81),
            ),
            selectedIcon: Icon(
              Icons.home,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: 'Trang chủ',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.block_outlined,
              color: isDark ? const Color.fromARGB(255, 71, 71, 71) : Colors.grey[600],
            ),
            selectedIcon: Icon(
              Icons.block,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: 'Khóa ứng dụng',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.timer_outlined,
              color: isDark ? const Color.fromARGB(255, 71, 71, 71) : Colors.grey[600],
            ),
            selectedIcon: Icon(
              Icons.timer,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: 'Quản lý',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.self_improvement_outlined,
              color: isDark ? const Color.fromARGB(255, 71, 71, 71) : Colors.grey[600],
            ),
            selectedIcon: Icon(
              Icons.self_improvement,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: 'Tập trung',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.settings_outlined,
              color: isDark ? const Color.fromARGB(255, 71, 71, 71) : Colors.grey[600],
            ),
            selectedIcon: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: 'Cài đặt',
          ),
        ],
      ),
    );
  }
}