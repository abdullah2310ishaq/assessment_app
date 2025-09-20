import 'package:flutter/material.dart';
import '../models/win_model.dart';
import 'founder_avatar.dart';
import 'reactions_row.dart';

class WinCard extends StatelessWidget {
  final Win win;
  final VoidCallback? onReaction;
  final Function(String emoji)? onReactionTap;

  const WinCard({
    Key? key,
    required this.win,
    this.onReaction,
    this.onReactionTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: _buildCardDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderRow(),
            const SizedBox(height: 12),
            _buildContent(),
            const SizedBox(height: 12),
            ReactionsRow(
              reactions: win.reactions,
              onReactionTap: onReactionTap,
              onReaction: onReaction,
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildCardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
      border: Border.all(color: Colors.grey.withOpacity(0.1)),
    );
  }

  Widget _buildHeaderRow() {
    return Row(
      children: [
        FounderAvatar(
          avatar: win.avatar,
          backgroundColor: const Color(0xFF667eea).withOpacity(0.1),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                win.founderName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                win.company,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Text(
          _formatTimestamp(win.timestamp),
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Text(
      win.content,
      style: const TextStyle(
        fontSize: 14,
        height: 1.4,
        color: Color(0xFF333333),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}