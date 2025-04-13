import 'package:flutter/material.dart';
import 'register_screen.dart'; // Import màn hình đăng ký

class LoginScreen extends StatefulWidget {
  final VoidCallback onLogin;

  const LoginScreen({super.key, required this.onLogin});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
      ),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark 
              ? [
                  const Color(0xFF1A1A2E),
                  const Color(0xFF16213E),
                  const Color(0xFF0F3460),
                ]
              : [
                  const Color(0xFFE0F7FA),
                  const Color(0xFFB2EBF2),
                  const Color(0xFF80DEEA),
                ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.05),
                  
                  // Logo và tiêu đề
                  FadeTransition(
                    opacity: _fadeInAnimation,
                    child: Column(
                      children: [
                        // Logo ứng dụng
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: isDark ? Colors.blueGrey.shade800 : Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.timelapse_rounded,
                              size: 60,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Tiêu đề ứng dụng
                        Text(
                          'Smart Management',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                            letterSpacing: 1.2,
                          ),
                        ),
                        
                        const SizedBox(height: 8),
                        
                        // Phụ đề
                        Text(
                          'Quản lý thời gian và tập trung hiệu quả',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.white70 : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: size.height * 0.05),
                  
                  // Form đăng nhập
                  FadeTransition(
                    opacity: _fadeInAnimation,
                    child: Column(
                      children: [
                        // Trường tên đăng nhập
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Tên đăng nhập',
                            hintText: 'Nhập tên đăng nhập hoặc email',
                            prefixIcon: const Icon(Icons.person_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: isDark ? Colors.white30 : Colors.black26,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: theme.colorScheme.primary,
                                width: 2,
                              ),
                            ),
                            filled: true,
                            fillColor: isDark 
                                ? Colors.blueGrey.shade900.withOpacity(0.5) 
                                : Colors.white.withOpacity(0.9),
                          ),
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Trường mật khẩu
                        TextField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: 'Mật khẩu',
                            hintText: 'Nhập mật khẩu của bạn',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword 
                                    ? Icons.visibility_outlined 
                                    : Icons.visibility_off_outlined,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: isDark ? Colors.white30 : Colors.black26,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: theme.colorScheme.primary,
                                width: 2,
                              ),
                            ),
                            filled: true,
                            fillColor: isDark 
                                ? Colors.blueGrey.shade900.withOpacity(0.5) 
                                : Colors.white.withOpacity(0.9),
                          ),
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Xử lý quên mật khẩu
                            },
                            child: Text(
                              'Quên mật khẩu?',
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 8),
                        
                        // Nút đăng nhập
                        ElevatedButton(
                          onPressed: () {
                            // Xử lý đăng nhập bằng tài khoản/mật khẩu
                            if (_usernameController.text.isNotEmpty && 
                                _passwordController.text.isNotEmpty) {
                              _showSuccessSnackbar(
                                context, 
                                'Đăng nhập thành công!',
                                theme.colorScheme.primary,
                              );
                              
                              Future.delayed(const Duration(seconds: 1), () {
                                widget.onLogin();
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Vui lòng nhập tên đăng nhập và mật khẩu'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: theme.colorScheme.onPrimary,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            minimumSize: const Size(double.infinity, 56),
                            elevation: 5,
                            shadowColor: theme.colorScheme.primary.withOpacity(0.5),
                          ),
                          child: const Text(
                            'ĐĂNG NHẬP',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Phần đăng ký
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Chưa có tài khoản?',
                              style: TextStyle(
                                color: isDark ? Colors.white70 : Colors.black54,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // Chuyển đến màn hình đăng ký
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RegisterScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Đăng ký ngay',
                                style: TextStyle(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Divider
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: isDark ? Colors.white30 : Colors.black26,
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'Hoặc đăng nhập với',
                                style: TextStyle(
                                  color: isDark ? Colors.white60 : Colors.black45,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: isDark ? Colors.white30 : Colors.black26,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Thu gọn các nút đăng nhập bằng mạng xã hội
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Gmail login
                            _buildSocialLoginButton(
                              onPressed: () => _mockGmailLogin(context),
                              icon: Icons.mail_outline,
                              backgroundColor: Colors.white,
                              iconColor: Colors.red,
                              borderColor: Colors.grey.shade300,
                            ),
                            
                            const SizedBox(width: 24),
                            
                            // Facebook login
                            _buildSocialLoginButton(
                              onPressed: () => _mockFacebookLogin(context),
                              icon: Icons.facebook,
                              backgroundColor: const Color(0xFF1877F2),
                              iconColor: Colors.white,
                              borderColor: Colors.transparent,
                            ),
                            
                            const SizedBox(width: 24),
                            
                            // Guest login
                            _buildSocialLoginButton(
                              onPressed: () => _mockGuestLogin(context),
                              icon: Icons.person_outline,
                              backgroundColor: isDark 
                                  ? Colors.blueGrey.shade700 
                                  : Colors.grey.shade200,
                              iconColor: isDark ? Colors.white : Colors.black87,
                              borderColor: Colors.transparent,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: size.height * 0.03),
                  
                  // Văn bản ghi chú
                  FadeTransition(
                    opacity: _fadeInAnimation,
                    child: Text(
                      'Bằng cách đăng nhập, bạn đồng ý với Điều khoản dịch vụ và Chính sách riêng tư của chúng tôi',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.white60 : Colors.black45,
                      ),
                    ),
                  ),
                  
                  SizedBox(height: size.height * 0.03),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget nút mạng xã hội
  Widget _buildSocialLoginButton({
    required VoidCallback onPressed,
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
    required Color borderColor,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(50),
        child: Ink(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            border: Border.all(color: borderColor),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 24,
          ),
        ),
      ),
    );
  }

  // Các hàm giả lập đăng nhập
  void _mockGmailLogin(BuildContext context) {
    // Hiển thị thông báo đăng nhập thành công
    _showSuccessSnackbar(
      context, 
      'Đăng nhập bằng Gmail thành công!',
      Colors.red.shade400,
    );
    
    // Gọi callback đăng nhập
    Future.delayed(const Duration(seconds: 1), () {
      widget.onLogin();
    });
  }

  void _mockFacebookLogin(BuildContext context) {
    // Hiển thị thông báo đăng nhập thành công
    _showSuccessSnackbar(
      context, 
      'Đăng nhập bằng Facebook thành công!',
      const Color(0xFF1877F2),
    );
    
    // Gọi callback đăng nhập
    Future.delayed(const Duration(seconds: 1), () {
      widget.onLogin();
    });
  }

  void _mockGuestLogin(BuildContext context) {
    // Hiển thị thông báo đăng nhập thành công
    _showSuccessSnackbar(
      context, 
      'Đăng nhập dưới dạng khách thành công!',
      Colors.grey.shade700,
    );
    
    // Gọi callback đăng nhập
    Future.delayed(const Duration(seconds: 1), () {
      widget.onLogin();
    });
  }

  // Hiển thị Snackbar với thiết kế đẹp hơn
  void _showSuccessSnackbar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.white),
            const SizedBox(width: 12),
            Text(message),
          ],
        ),
        backgroundColor: color,
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}