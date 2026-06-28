import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import 'app_avatar.dart';

class AvatarGroup extends StatelessWidget {
  final List<String?> imageUrls;
  final double size;
  final int maxVisible;

  const AvatarGroup({
    super.key,
    required this.imageUrls,
    this.size = 32.0,
    this.maxVisible = 3,
  });

  @override
  Widget build(BuildContext context) {
    final visibleCount =
        imageUrls.length > maxVisible ? maxVisible : imageUrls.length;
    final extraCount = imageUrls.length - maxVisible;

    return SizedBox(
      height: size,
      width:
          size +
          (visibleCount - 1) * (size * 0.6) +
          (extraCount > 0 ? size * 0.6 : 0),
      child: Stack(
        children: [
          for (int i = 0; i < visibleCount; i++)
            Positioned(
              left: i * (size * 0.6),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 2,
                  ),
                ),
                child: AppAvatar(
                  imageUrl: imageUrls[i],
                  name: '?', // generic fallback
                  radius: size / 2,
                ),
              ),
            ),
          if (extraCount > 0)
            Positioned(
              left: visibleCount * (size * 0.6),
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainer,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 2,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  '+$extraCount',
                  style: TextStyle(
                    fontSize: size * 0.35,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
