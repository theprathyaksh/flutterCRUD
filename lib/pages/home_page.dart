import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:crud/services/firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RealtimeDatabaseService _databaseService = RealtimeDatabaseService();
  final TextEditingController _controller = TextEditingController();

  void _openNoteBox({String? id, String? existingNote}) {
    _controller.text = existingNote ?? '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(id == null ? "Add Note" : "Edit Note"),
        content: TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: "Enter your note"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (id == null) {
                _databaseService.addNote(_controller.text.trim());
              } else {
                _databaseService.updateNote(id, _controller.text.trim());
              }
              _controller.clear();
              Navigator.of(context).pop();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notes")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openNoteBox(),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<DatabaseEvent>(
        stream: _databaseService.getNotesQuery().onValue,
        builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return const Center(child: CircularProgressIndicator());
          // }
          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return const Center(child: Text("No notes available"));
          }
          final notesMap = Map<String, dynamic>.from(
            (snapshot.data!.snapshot.value as Map),
          );
          final notes = notesMap.entries.toList();
          notes.sort((a, b) => b.value['timestamp'].compareTo(a.value['timestamp']));

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final noteEntry = notes[index];
              return ListTile(
                title: Text(noteEntry.value['note']),
                subtitle: Text(noteEntry.value['timestamp']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _openNoteBox(
                        id: noteEntry.key,
                        existingNote: noteEntry.value['note'],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _databaseService.deleteNote(noteEntry.key),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
