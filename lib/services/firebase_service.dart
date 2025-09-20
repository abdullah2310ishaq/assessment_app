import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/win_model.dart';

class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _winsCollection = 'wins';

  // Get all wins in real-time
  static Stream<List<Win>> getWinsStream() {
    return _firestore
        .collection(_winsCollection)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Win.fromMap(data, doc.id);
      }).toList();
    });
  }

  // Add a new win
  static Future<void> addWin(Win win) async {
    await _firestore.collection(_winsCollection).add(win.toMap());
  }

  // Update reactions for a win
  static Future<void> updateReactions(String winId, Map<String, int> reactions) async {
    await _firestore
        .collection(_winsCollection)
        .doc(winId)
        .update({'reactions': reactions});
  }

  // Add a reaction to a specific win
  static Future<void> addReaction(String winId, String emoji) async {
    final winRef = _firestore.collection(_winsCollection).doc(winId);
    
    await _firestore.runTransaction((transaction) async {
      final winDoc = await transaction.get(winRef);
      if (winDoc.exists) {
        final data = winDoc.data()!;
        final reactions = Map<String, int>.from(data['reactions'] ?? {});
        reactions[emoji] = (reactions[emoji] ?? 0) + 1;
        transaction.update(winRef, {'reactions': reactions});
      }
    });
  }

  // Get founder stats (total wins, total reactions received)
  static Future<Map<String, dynamic>> getFounderStats(String founderName) async {
    final winsQuery = await _firestore
        .collection(_winsCollection)
        .where('founderName', isEqualTo: founderName)
        .get();

    int totalWins = winsQuery.docs.length;
    int totalReactions = 0;

    for (final doc in winsQuery.docs) {
      final reactions = Map<String, int>.from(doc.data()['reactions'] ?? {});
      totalReactions += reactions.values.fold(0, (sum, count) => sum + count);
    }

    return {
      'totalWins': totalWins,
      'totalReactions': totalReactions,
    };
  }
}