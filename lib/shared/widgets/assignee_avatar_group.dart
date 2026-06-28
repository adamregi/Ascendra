import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'app_avatar.dart';

class AssigneeAvatarGroup extends StatelessWidget {
  final List<String> assigneeNames;
  final double radius;
  final int maxAvatars;

  const AssigneeAvatarGroup({
    super.key,
    required this.assigneeNames,
    this.radius = 16,
    this.maxAvatars = 3,
  });

  @override
  Widget build(BuildContext context) {
    if (assigneeNames.isEmpty) return const SizedBox.shrink();

    final displayCount =
        assigneeNames.length > maxAvatars ? maxAvatars : assigneeNames.length;
    final remainingCount = assigneeNames.length - displayCount;

    return SizedBox(
      height: radius * 2,
      width:
          (radius * 2) +
          ((displayCount - 1) * radius) +
          (remainingCount > 0 ? radius : 0),
      child: Stack(
        children: [
          for (int i = 0; i < displayCount; i++)
            Positioned(
              left: i * radius,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 2,
                  ),
                ),
                child: AppAvatar(name: assigneeNames[i], radius: radius - 2),
              ),
            ),
          if (remainingCount > 0)
            Positioned(
              left: displayCount * radius,
              child: Container(
                width: (radius * 2) - 4,
                height: (radius * 2) - 4,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    '+$remainingCount',
                    style: TextStyle(
                      fontSize: radius * 0.7,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
