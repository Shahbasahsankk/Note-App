import 'package:flutter/material.dart';
import 'package:note_app_api/services/notes_sevices.dart';
class NoteDelete extends StatelessWidget {
  const NoteDelete({super.key, this.noteID});
 final String? noteID;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Warning'),
      content: const Text('Are you sure you want to delte this note?'),
      actions: [
        TextButton(
          onPressed: ()async {
            await NoteService().deleteNotes(noteID.toString());
            Navigator.of(context).pop(true);
          },
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text('No'),
        ),
      ],
    );
  }
}
