// services/realtime_database_service.dart

import 'package:firebase_database/firebase_database.dart';

class RealtimeDatabaseService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref("notes");

  Future<void> addNote(String note) async {
    final newNoteRef = _dbRef.push();
    await newNoteRef.set({
      'note': note,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  Future<void> updateNote(String id, String note) async {
    await _dbRef.child(id).update({
      'note': note,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  Future<void> deleteNote(String id) async {
    await _dbRef.child(id).remove();
  }

  Query getNotesQuery() {
    return _dbRef.orderByChild('timestamp');
  }
}
