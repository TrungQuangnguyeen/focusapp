import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  
  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Gradient Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark ? [
                  const Color(0xFF0F2027),
                  const Color(0xFF203A43),
                  const Color(0xFF2C5364),
                ] : [
                  const Color(0xFF0D47A1), // Xanh đậm
                  const Color(0xFF1976D2), // Xanh trung bình
                  const Color(0xFF42A5F5), // Xanh nhạt
                ],
              ),
            ),
          ),
          
          // Hiệu ứng trang trí - các hình tròn
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          
          Positioned(
            bottom: -150,
            left: -50,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          
          // Nội dung chính
          SafeArea(
            bottom: false,
            child: child,
          ),
        ],
      ),
    );
  }
}