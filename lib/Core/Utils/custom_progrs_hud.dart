import 'package:flutter/material.dart';

class CustomProgressHUD extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const CustomProgressHUD({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading) ...[
          Container(
            color: Colors.blue.withOpacity(0.7),
            child: const Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
