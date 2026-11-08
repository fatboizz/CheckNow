import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// Reusable action button widget.
class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const CustomButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.primaryClr,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

/// Backward compatibility alias.
typedef MyButton = CustomButton;
