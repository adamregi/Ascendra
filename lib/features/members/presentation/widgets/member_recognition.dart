import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../domain/entities/member_profile.dart';

class MemberRecognitionList extends StatelessWidget {
  final List<MemberRecognition> recognitions;

  const MemberRecognitionList({super.key, required this.recognitions});

  @override
  Widget build(BuildContext context) {
    if (recognitions.isEmpty) {
      return const Center(child: Text('No recognitions earned yet.'));
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: recognitions.length,
      itemBuilder: (context, index) {
        final rec = recognitions[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: AppCard(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                const Icon(Icons.emoji_events, size: 32, color: Colors.amber),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rec.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(rec.description),
                    ],
                  ),
                ),
                Text(
                  '+${rec.points}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
