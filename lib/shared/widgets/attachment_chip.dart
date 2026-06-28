import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AttachmentChip extends StatelessWidget {
  final String fileName;
  final String type; // 'image', 'pdf', 'url'
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  const AttachmentChip({
    super.key,
    required this.fileName,
    required this.type,
    this.onTap,
    this.onRemove,
  });

  IconData _getIcon() {
    switch (type.toLowerCase()) {
      case 'image':
        return LucideIcons.image;
      case 'pdf':
        return LucideIcons.fileText;
      case 'url':
        return LucideIcons.link;
      default:
        return LucideIcons.paperclip;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(color: AppColors.borderSubtle),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(_getIcon(), size: 16, color: AppColors.primary),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                fileName,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (onRemove != null) ...[
              const SizedBox(width: 8),
              InkWell(
                onTap: onRemove,
                child: const Icon(
                  LucideIcons.x,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
