import 'package:flutter/material.dart';
import 'package:hmssdk_flutter/hmssdk_flutter.dart';
import 'participant_tile.dart';

class VideoGrid extends StatelessWidget {
  final HMSLocalPeer? localPeer;
  final List<HMSPeer> remotePeers;

  const VideoGrid({
    super.key,
    required this.localPeer,
    required this.remotePeers,
  });

  @override
  Widget build(BuildContext context) {
    final allPeers = [
      if (localPeer != null) localPeer!,
      ...remotePeers,
    ];

    if (allPeers.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final count = allPeers.length;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isLandscape = constraints.maxWidth > constraints.maxHeight;

        if (count == 1) {
          return ParticipantTile(peer: allPeers[0]);
        } else if (count == 2) {
          return isLandscape
              ? Row(
                  children: [
                    Expanded(child: ParticipantTile(peer: allPeers[0])),
                    const SizedBox(width: 8),
                    Expanded(child: ParticipantTile(peer: allPeers[1])),
                  ],
                )
              : Column(
                  children: [
                    Expanded(child: ParticipantTile(peer: allPeers[0])),
                    const SizedBox(height: 8),
                    Expanded(child: ParticipantTile(peer: allPeers[1])),
                  ],
                );
        } else if (count == 3 || count == 4) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: isLandscape ? 4 / 3 : 3 / 4,
            ),
            itemCount: count,
            itemBuilder: (context, index) {
              return ParticipantTile(peer: allPeers[index]);
            },
          );
        } else {
          // Many participants - scrollable 2-column/3-column grid
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isLandscape ? 3 : 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: isLandscape ? 4 / 3 : 3 / 4,
            ),
            itemCount: count,
            itemBuilder: (context, index) {
              return ParticipantTile(peer: allPeers[index]);
            },
          );
        }
      },
    );
  }
}
