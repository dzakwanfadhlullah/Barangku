import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

class AppCardSection extends StatelessWidget {
  final String? title;
  final Widget child;

  const AppCardSection({
    super.key,
    this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: AppTextStyles.h3.copyWith(color: AppColors.olive700),
          ),
          const SizedBox(height: AppSpacing.m),
        ],
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.l),
            child: child,
          ),
        ),
      ],
    );
  }
}
