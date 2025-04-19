import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class BlockedAppScreen extends StatefulWidget {
  const BlockedAppScreen({super.key});

  @override
  State<BlockedAppScreen> createState() => _BlockedAppScreenState();
}

class _BlockedAppScreenState extends State<BlockedAppScreen> {
  // Sample data - replace with your actual data source
  final List<Map<String, dynamic>> _blockedApps = [
    {
      'name': 'Facebook',
      'icon': Icons.facebook,
      'color': Colors.blue,
      'timeLimit': 30,
      'isBlocked': true,
    },
    {
      'name': 'Instagram',
      'icon': Icons.camera_alt,
      'color': Colors.pink,
      'timeLimit': 45,
      'isBlocked': true,
    },
    {
      'name': 'YouTube',
      'icon': Icons.play_circle_fill,
      'color': Colors.red,
      'timeLimit': 60,
      'isBlocked': false,
    },
    {
      'name': 'TikTok',
      'icon': Icons.music_note,
      'color': Colors.black,
      'timeLimit': 20,
      'isBlocked': true,
    },
    {
      'name': 'Twitter',
      'icon': Icons.chat,
      'color': Colors.lightBlue,
      'timeLimit': 15,
      'isBlocked': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.grey[50],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Khóa ứng dụng',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Đặt giới hạn thời gian cho các ứng dụng để tập trung vào công việc',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            
            // Status overview
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassmorphicContainer(
                width: MediaQuery.of(context).size.width - 32, // Width minus padding
                height: 90,
                borderRadius: 16,
                blur: 20,
                alignment: Alignment.center,
                border: 1,
                linearGradient: LinearGradient(
                  colors: [
                    Colors.redAccent.withOpacity(0.7),
                    Colors.redAccent.withOpacity(0.4),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderGradient: LinearGradient(
                  colors: [
                    Colors.redAccent.withOpacity(0.4),
                    Colors.redAccent.withOpacity(0.2),
                  ],
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    const Icon(
                      Icons.block,
                      color: Colors.white,
                      size: 40,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '3 ứng dụng đang bị khóa',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Nhấp vào ứng dụng để cài đặt thời gian',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Apps list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Danh sách ứng dụng',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      // Show dialog to add new app
                      _showAddAppDialog();
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Thêm ứng dụng'),
                    style: TextButton.styleFrom(
                      foregroundColor: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 8),
            
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: _blockedApps.length,
                itemBuilder: (context, index) {
                  final app = _blockedApps[index];
                  return GlassmorphicContainer(
                    width: MediaQuery.of(context).size.width - 32,
                    height: 80,
                    borderRadius: 16,
                    blur: 10,
                    alignment: Alignment.center,
                    border: 1,
                    linearGradient: LinearGradient(
                      colors: [
                        isDark ? Colors.grey[850]!.withOpacity(0.7) : Colors.white.withOpacity(0.7),
                        isDark ? Colors.grey[900]!.withOpacity(0.4) : Colors.white.withOpacity(0.4),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderGradient: LinearGradient(
                      colors: [
                        isDark ? Colors.grey[800]!.withOpacity(0.5) : Colors.grey[300]!.withOpacity(0.5),
                        isDark ? Colors.grey[700]!.withOpacity(0.5) : Colors.grey[300]!.withOpacity(0.5),
                      ],
                    ),
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          // App icon
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: app['color'].withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              app['icon'],
                              color: app['color'],
                              size: 28,
                            ),
                          ),
                          
                          const SizedBox(width: 16),
                          
                          // App details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  app['name'],
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Giới hạn: ${app['timeLimit']} phút mỗi ngày',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: isDark 
                                        ? Colors.grey[400] 
                                        : Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Toggle switch
                          Switch(
                            value: app['isBlocked'],
                            onChanged: (value) {
                              setState(() {
                                app['isBlocked'] = value;
                              });
                            },
                            activeColor: theme.colorScheme.primary,
                          ),
                          
                          // Settings button
                          IconButton(
                            onPressed: () {
                              // Show app settings dialog
                              _showAppSettingsDialog(app);
                            },
                            icon: Icon(
                              Icons.settings,
                              color: isDark 
                                  ? Colors.grey[400] 
                                  : Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Enable/disable all blocks
          _showBlockAllDialog();
        },
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        icon: const Icon(Icons.block),
        label: const Text('Khóa tất cả'),
      ),
    );
  }
  
  void _showAddAppDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thêm ứng dụng mới'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // App selection, time limit settings, etc.
            const TextField(
              decoration: InputDecoration(
                labelText: 'Tên ứng dụng',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Chọn ứng dụng từ danh sách bên dưới:'),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: ListView(
                children: const [
                  ListTile(
                    leading: Icon(Icons.messenger, color: Colors.blue),
                    title: Text('Messenger'),
                  ),
                  ListTile(
                    leading: Icon(Icons.tiktok, color: Colors.black),
                    title: Text('TikTok'),
                  ),
                  ListTile(
                    leading: Icon(Icons.telegram, color: Colors.lightBlue),
                    title: Text('Telegram'),
                  ),
                  ListTile(
                    leading: Icon(Icons.games, color: Colors.green),
                    title: Text('Games'),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              // Add the app to blocked list
              Navigator.pop(context);
            },
            child: const Text('Thêm'),
          ),
        ],
      ),
    );
  }
  
  void _showAppSettingsDialog(Map<String, dynamic> app) {
    int timeLimit = app['timeLimit'];
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Cài đặt cho ${app['name']}'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Đặt giới hạn thời gian sử dụng:'),
                const SizedBox(height: 16),
                Slider(
                  value: timeLimit.toDouble(),
                  min: 5,
                  max: 120,
                  divisions: 23,
                  label: '$timeLimit phút',
                  onChanged: (value) {
                    setState(() {
                      timeLimit = value.round();
                    });
                  },
                ),
                Text('$timeLimit phút mỗi ngày', 
                  style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                const Text('Lịch trình:'),
                CheckboxListTile(
                  title: const Text('Tất cả các ngày'),
                  value: true,
                  onChanged: (value) {},
                ),
                CheckboxListTile(
                  title: const Text('Chặn thông báo'),
                  value: false,
                  onChanged: (value) {},
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Hủy'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Update the app settings
                  setState(() {
                    app['timeLimit'] = timeLimit;
                  });
                  Navigator.pop(context);
                },
                child: const Text('Lưu'),
              ),
            ],
          );
        }
      ),
    );
  }
  
  void _showBlockAllDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Khóa tất cả ứng dụng'),
        content: const Text(
          'Bạn có chắc chắn muốn khóa tất cả các ứng dụng đã chọn?'
          '\n\nKhi bật, bạn sẽ không thể sử dụng các ứng dụng này quá thời gian đã đặt.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              // Block all apps
              setState(() {
                for (var app in _blockedApps) {
                  app['isBlocked'] = true;
                }
              });
              Navigator.pop(context);
            },
            child: const Text('Khóa tất cả'),
          ),
        ],
      ),
    );
  }
}