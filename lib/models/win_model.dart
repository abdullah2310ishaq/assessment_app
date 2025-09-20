import 'package:cloud_firestore/cloud_firestore.dart';

class Win {
  final String id;
  final String founderName;
  final String company;
  final String content;
  final DateTime timestamp;
  final Map<String, int> reactions;
  final String avatar;

  Win({
    required this.id,
    required this.founderName,
    required this.company,
    required this.content,
    required this.timestamp,
    required this.reactions,
    required this.avatar,
  });

  // Convert Win to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'founderName': founderName,
      'company': company,
      'content': content,
      'timestamp': Timestamp.fromDate(timestamp),
      'reactions': reactions,
      'avatar': avatar,
    };
  }

  // Create Win from Firestore document
  factory Win.fromMap(Map<String, dynamic> map, String documentId) {
    return Win(
      id: documentId,
      founderName: map['founderName'] ?? '',
      company: map['company'] ?? '',
      content: map['content'] ?? '',
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      reactions: Map<String, int>.from(map['reactions'] ?? {}),
      avatar: map['avatar'] ?? '🚀',
    );
  }

  // Create a copy with updated values
  Win copyWith({
    String? id,
    String? founderName,
    String? company,
    String? content,
    DateTime? timestamp,
    Map<String, int>? reactions,
    String? avatar,
  }) {
    return Win(
      id: id ?? this.id,
      founderName: founderName ?? this.founderName,
      company: company ?? this.company,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      reactions: reactions ?? this.reactions,
      avatar: avatar ?? this.avatar,
    );
  }
}