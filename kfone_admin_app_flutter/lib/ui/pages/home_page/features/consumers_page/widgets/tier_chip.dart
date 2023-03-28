import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

/// Types of the tier chips.
enum TierChipType {
  no,
  silver,
  gold,
  platinum,
}

class TierChip extends StatelessWidget {
  final TierChipType tierChipType;

  const TierChip({super.key, required this.tierChipType});

  @override
  Widget build(BuildContext context) {
    switch (tierChipType) {
      case TierChipType.no:
        return Chip(
          backgroundColor: Colors.grey[200], //CircleAvatar
          label: const Text('Default'), //Text
        );
      case TierChipType.silver:
        return Chip(
          backgroundColor: Colors.blueGrey[100], //CircleAvatar
          label: const Text('Silver'), //Text
        );
      case TierChipType.gold:
        return const Chip(
          backgroundColor: Colors.yellow, //CircleAvatar
          label: Text('Gold'), //Text
        );
      case TierChipType.platinum:
        return Chip(
          backgroundColor: Colors.blueGrey[400], //CircleAvatar
          label: const Text('Platinum'), //Text
        );
    }
  }
}
