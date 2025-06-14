import 'package:cloud_firestore/cloud_firestore.dart';

class MoodService {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('mood_logs');

  Stream<QuerySnapshot> getMoodLogs() {
    return _collection.orderBy('timestamp', descending: true).snapshots();
  }
}
