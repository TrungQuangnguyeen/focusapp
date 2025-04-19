import 'package:flutter/material.dart';
import 'widgets/feature_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Header section
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
                      child: Icon(
                        Icons.person,
                        color: theme.colorScheme.primary,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Xin chào,',
                          style: theme.textTheme.bodyLarge,
                        ),
                        Text(
                          'Nguyễn Quang Trung',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
                const SizedBox(height: 30),
                
                // Stats overview
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primary,
                        theme.colorScheme.primary.withOpacity(0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Thống kê hôm nay',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatItem(
                              context,
                              Icons.schedule,
                              '3.5 giờ',
                              'Thời gian sử dụng',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildStatItem(
                              context,
                              Icons.block,
                              '7 lần',
                              'Ứng dụng bị chặn',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatItem(
                              context,
                              Icons.self_improvement,
                              '2 phiên',
                              'Tập trung',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildStatItem(
                              context,
                              Icons.emoji_events,
                              '85%',
                              'Hiệu suất',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Features section
                Text(
                  'Tính năng',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Feature cards grid
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                  children: [
                    FeatureCard(
                      icon: Icons.block,
                      title: 'Khóa ứng dụng',
                      subtitle: 'Giới hạn sử dụng',
                      color: Colors.redAccent,
                      isDark: isDark,
                    ),
                    FeatureCard(
                      icon: Icons.timer,
                      title: 'Quản lý thời gian',
                      subtitle: 'Xem thống kê sử dụng',
                      color: Colors.blueAccent,
                      isDark: isDark,
                    ),
                    FeatureCard(
                      icon: Icons.self_improvement,
                      title: 'Chế độ tập trung',
                      subtitle: 'Tăng hiệu suất làm việc',
                      color: Colors.purpleAccent,
                      isDark: isDark,
                    ),
                    FeatureCard(
                      icon: Icons.insights,
                      title: 'Báo cáo',
                      subtitle: 'Phân tích thói quen',
                      color: Colors.orangeAccent,
                      isDark: isDark,
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // Recent activity
                Text(
                  'Hoạt động gần đây',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Activity list
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  separatorBuilder: (context, index) => Divider(
                    color: isDark ? Colors.grey[800] : Colors.grey[300],
                  ),
                  itemBuilder: (context, index) {
                    final List<Map<String, dynamic>> activities = [
                      {
                        'icon': Icons.block,
                        'title': 'Facebook bị chặn',
                        'time': '10 phút trước',
                        'color': Colors.redAccent,
                      },
                      {
                        'icon': Icons.self_improvement,
                        'title': 'Hoàn thành phiên tập trung',
                        'time': '1 giờ trước',
                        'color': Colors.greenAccent,
                      },
                      {
                        'icon': Icons.timer,
                        'title': 'Đã đặt hẹn giờ cho YouTube',
                        'time': '2 giờ trước',
                        'color': Colors.orangeAccent,
                      },
                    ];
                    
                    final activity = activities[index];
                    
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: activity['color'].withOpacity(0.2),
                        child: Icon(
                          activity['icon'],
                          color: activity['color'],
                        ),
                      ),
                      title: Text(
                        activity['title'],
                        style: theme.textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        activity['time'],
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: isDark ? Colors.grey[600] : Colors.grey[400],
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildStatItem(BuildContext context, IconData icon, String value, String label) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 22,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}