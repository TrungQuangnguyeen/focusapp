import 'package:flutter/material.dart';
import '../../widgets/focus_mode_card.dart';
import '../../widgets/control_button.dart';

class FocusModeScreen extends StatefulWidget {
  const FocusModeScreen({super.key});

  @override
  State<FocusModeScreen> createState() => _FocusModeScreenState();
}

class _FocusModeScreenState extends State<FocusModeScreen> {
  bool _isFocusModeActive = false;
  int _selectedFocusTime = 25; // Default pomodoro time

  void _toggleFocusMode() {
    setState(() {
      _isFocusModeActive = !_isFocusModeActive;
    });
  }

  void _selectFocusTime(int minutes) {
    setState(() {
      _selectedFocusTime = minutes;
    });
  }

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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chế độ Tập trung',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                // Focus mode cards
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FocusModeCard(
                      title: 'Pomodoro',
                      minutes: 25,
                      isSelected: _selectedFocusTime == 25,
                      onSelect: _selectFocusTime,
                    ),
                    FocusModeCard(
                      title: 'Deep Work',
                      minutes: 50,
                      isSelected: _selectedFocusTime == 50,
                      onSelect: _selectFocusTime,
                    ),
                    FocusModeCard(
                      title: 'Custom',
                      minutes: 90,
                      isSelected: _selectedFocusTime == 90,
                      onSelect: _selectFocusTime,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Timer display
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          _isFocusModeActive ? 'Đang tập trung' : 'Sẵn sàng',
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isDark ? Colors.grey[850] : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: isDark
                                    ? Colors.black.withOpacity(0.3)
                                    : Colors.grey.withOpacity(0.2),
                                blurRadius: 15,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Text(
                            '$_selectedFocusTime:00',
                            style: theme.textTheme.displayLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: _isFocusModeActive
                                  ? theme.colorScheme.primary
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Control buttons
                Center(
                  child: ControlButton(
                    icon: _isFocusModeActive
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_fill,
                    label: _isFocusModeActive ? 'Tạm dừng' : 'Bắt đầu',
                    onPressed: _toggleFocusMode,
                    isPrimary: true,
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: ControlButton(
                    icon: Icons.stop_circle,
                    label: 'Kết thúc',
                    onPressed: () {
                      setState(() {
                        _isFocusModeActive = false;
                      });
                    },
                  ),
                ),
                // Session history section
                const SizedBox(height: 30),
                Text(
                  'Lịch sử phiên làm việc',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[850] : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: isDark
                            ? Colors.black.withOpacity(0.3)
                            : Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildSessionItem(
                        context,
                        'Hôm nay, 10:30 AM',
                        '25 phút',
                        'Hoàn thành',
                        Icons.check_circle,
                        Colors.green,
                      ),
                      const Divider(),
                      _buildSessionItem(
                        context,
                        'Hôm nay, 09:00 AM',
                        '50 phút',
                        'Hoàn thành',
                        Icons.check_circle,
                        Colors.green,
                      ),
                      const Divider(),
                      _buildSessionItem(
                        context,
                        'Hôm qua, 03:45 PM',
                        '25 phút',
                        'Đã hủy',
                        Icons.cancel,
                        Colors.red,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSessionItem(
    BuildContext context,
    String time,
    String duration,
    String status,
    IconData icon,
    Color color,
  ) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            time,
            style: theme.textTheme.bodyMedium,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            duration,
            style: theme.textTheme.bodyMedium,
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                status,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}