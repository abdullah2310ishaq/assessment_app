import 'package:flutter/material.dart';

class ReactionsRow extends StatelessWidget {
  final Map<String, int> reactions;
  final Function(String emoji)? onReactionTap;
  final VoidCallback? onReaction;

  const ReactionsRow({
    Key? key,
    required this.reactions,
    this.onReactionTap,
    this.onReaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...reactions.entries.map((entry) => _buildReactionChip(entry)),
        const Spacer(),
        if (onReaction != null) _buildQuickReactionButton(),
      ],
    );
  }

  Widget _buildReactionChip(MapEntry<String, int> reaction) {
    return GestureDetector(
      onTap: () => onReactionTap?.call(reaction.key),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF667eea).withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(reaction.key, style: const TextStyle(fontSize: 14)),
            const SizedBox(width: 4),
            Text(
              '${reaction.value}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF667eea),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickReactionButton() {
    return GestureDetector(
      onTap: onReaction,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text('🔥', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}