import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:note_app_api/models/list_note_model.dart';
import 'package:note_app_api/models/note_adding.dart';
import 'package:note_app_api/services/notes_sevices.dart';
import 'package:note_app_api/views/note_list.dart';

class NoteModify extends StatefulWidget {
  const NoteModify({super.key, this.noteId});
  final String? noteId;

  @override
  State<NoteModify> createState() => _NoteModifyState();
}

class _NoteModifyState extends State<NoteModify> {
  bool get isEditing => widget.noteId != null;
  final TextEditingController noteTitleController = TextEditingController();
  final TextEditingController noteContentController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      setState(() {
        isLoading = true;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await NoteService().getSingleNote(widget.noteId!).then((response) {
          setState(() {
            isLoading = false;
          });

          if (response.error == true) {
            log(response.errorMessage.toString());
            final errorMessage = response.errorMessage.toString();
            return errorMessage;
          }
          final SingleNote? note = response.data;
          noteTitleController.text = note!.noteTitle.toString();
          noteContentController.text = note.noteContent.toString();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Note' : 'Create Note'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  TextField(
                    controller: noteTitleController,
                    decoration: const InputDecoration(hintText: 'Note Title'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: noteContentController,
                    decoration: const InputDecoration(hintText: 'Note Content'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (isEditing) {
                        final note = NoteForAdding(
                          noteTitle: noteTitleController.text,
                          noteContent: noteContentController.text,
                        );
                        await NoteService().updateNotes(widget.noteId.toString(),note);
                      } else {
                        final note = NoteForAdding(
                          noteTitle: noteTitleController.text,
                          noteContent: noteContentController.text,
                        );
                        await NoteService().addNotes(note);
                      }
                      if(!mounted){}
                  
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                          builder: ((context) => const NoteList())), (route) => false);
                    },
                    child: Text(isEditing ? 'Save' : 'Submit'),
                  )
                ],
              ),
      ),
    );
  }
}
