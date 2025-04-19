import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Mock data - trong ứng dụng thực tế, dữ liệu này sẽ được lấy từ database hoặc API
  String _userName = "Nguyễn Văn A";
  String _email = "nguyenvana@example.com";
  String _phoneNumber = "0912345678";
  int _daysActive = 14;
  int _completedTasks = 38;
  int _focusHours = 26;
  
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _userName);
    _emailController = TextEditingController(text: _email);
    _phoneController = TextEditingController(text: _phoneNumber);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      if (_isEditing) {
        // Lưu các thông tin khi nhấn nút "Lưu"
        if (_formKey.currentState!.validate()) {
          _userName = _nameController.text;
          _email = _emailController.text;
          _phoneNumber = _phoneController.text;
          // Trong ứng dụng thực tế, bạn sẽ lưu dữ liệu vào database hoặc API ở đây
          _showSnackBar('Cập nhật thông tin thành công');
        } else {
          return; // Không thoát chế độ chỉnh sửa nếu form không hợp lệ
        }
      }
      _isEditing = !_isEditing;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Thông tin cá nhân',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black87,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          TextButton(
            onPressed: _toggleEdit,
            child: Text(
              _isEditing ? 'Lưu' : 'Chỉnh sửa',
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar và thông tin hiển thị ở trên
              _buildProfileHeader(isDark, theme),
              
              const SizedBox(height: 24),
              
              // Thống kê người dùng
              _buildUserStatistics(isDark, theme),
              
              const SizedBox(height: 24),
              
              // Form thông tin cá nhân
              _buildProfileForm(isDark, theme),
              
              const SizedBox(height: 24),
              
              // Các tùy chọn bảo mật
              _buildSecurityOptions(isDark, theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(bool isDark, ThemeData theme) {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              // Avatar dạng icon thay vì dùng hình ảnh
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.colorScheme.primary,
                    width: 2,
                  ),
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                ),
                child: Center(
                  child: Icon(
                    Icons.person,
                    size: 80,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              
              // Nút chỉnh sửa avatar
              if (_isEditing)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt, size: 20),
                      color: Colors.white,
                      onPressed: () {
                        // Xử lý logic thay đổi avatar ở đây
                        _showSnackBar('Tính năng đang phát triển');
                      },
                    ),
                  ),
                ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Tên người dùng
          Text(
            _userName,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          
          const SizedBox(height: 4),
          
          // Email
          Text(
            _email,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDark ? Colors.white70 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserStatistics(bool isDark, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thống kê hoạt động',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          
          const SizedBox(height: 16),
          
          Row(
            children: [
              _buildStatItem(
                isDark,
                theme,
                Icons.calendar_today,
                '$_daysActive ngày',
                'Hoạt động',
              ),
              _buildStatItem(
                isDark,
                theme,
                Icons.task_alt,
                '$_completedTasks công việc',
                'Hoàn thành',
              ),
              _buildStatItem(
                isDark,
                theme,
                Icons.timelapse,
                '$_focusHours giờ',
                'Tập trung',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Expanded _buildStatItem(
    bool isDark,
    ThemeData theme,
    IconData icon,
    String value,
    String label,
  ) {
    return Expanded(
      child: Column(
        children: [
          Icon(
            icon,
            color: theme.colorScheme.primary,
            size: 28,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: isDark ? Colors.white70 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileForm(bool isDark, ThemeData theme) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[850] : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thông tin cá nhân',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Trường họ tên
            _buildTextField(
              controller: _nameController,
              label: 'Họ và tên',
              icon: Icons.person_outline,
              enabled: _isEditing,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập họ và tên';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 16),
            
            // Trường email
            _buildTextField(
              controller: _emailController,
              label: 'Email',
              icon: Icons.email_outlined,
              enabled: _isEditing,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập email';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  return 'Email không hợp lệ';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 16),
            
            // Trường số điện thoại
            _buildTextField(
              controller: _phoneController,
              label: 'Số điện thoại',
              icon: Icons.phone_outlined,
              enabled: _isEditing,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập số điện thoại';
                }
                if (!RegExp(r'^[0-9]{10,11}$').hasMatch(value)) {
                  return 'Số điện thoại không hợp lệ';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool enabled,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      enabled: enabled,
      validator: validator,
      style: TextStyle(
        color: isDark ? Colors.white : Colors.black87,
      ),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? Colors.white30 : Colors.black26,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? Colors.white30 : Colors.black26,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
            width: 2,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? Colors.white10 : Colors.black12,
          ),
        ),
        filled: true,
        fillColor: enabled 
            ? isDark ? Colors.grey[800] : Colors.grey[50]
            : isDark ? Colors.grey[900]?.withOpacity(0.3) ?? Colors.grey[800] : Colors.grey[100],
      ),
    );
  }

  Widget _buildSecurityOptions(bool isDark, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bảo mật',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Các tùy chọn bảo mật
          _buildSecurityOption(
            isDark,
            theme,
            'Đổi mật khẩu',
            Icons.lock_outline,
            () {
              // Xử lý đổi mật khẩu
              _showSnackBar('Tính năng đang phát triển');
            },
          ),
          
          _buildSecurityOption(
            isDark,
            theme,
            'Xóa tài khoản',
            Icons.delete_outline,
            () {
              // Xử lý xóa tài khoản
              _showDialog(
                'Xóa tài khoản',
                'Bạn có chắc chắn muốn xóa tài khoản? Hành động này không thể hoàn tác.',
                () {
                  _showSnackBar('Tính năng đang phát triển');
                  Navigator.pop(context);
                },
              );
            },
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityOption(
    bool isDark,
    ThemeData theme,
    String title,
    IconData icon,
    VoidCallback onTap, {
    Color? color,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: color ?? (isDark ? Colors.white70 : Colors.black54),
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: color ?? (isDark ? Colors.white : Colors.black87),
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: isDark ? Colors.white70 : Colors.black54,
      ),
      onTap: onTap,
    );
  }

  void _showDialog(String title, String content, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: onConfirm,
            child: const Text(
              'Xác nhận',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}