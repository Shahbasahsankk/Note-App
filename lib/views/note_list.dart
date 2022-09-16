import 'package:flutter/material.dart';
import 'package:note_app_api/services/notes_sevices.dart';
import 'package:note_app_api/views/note_delete.dart';
import 'package:note_app_api/views/note_modify.dart';

import '../models/api_response.dart';
import '../models/list_note_model.dart';

class NoteList extends StatefulWidget {
  const NoteList({super.key});

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  String formateDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Of Notes'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) => const NoteModify()),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<APIResponse<List<NoteForListing>>>(
        future: NoteService().getNotes(),
        builder: (BuildContext context,
            AsyncSnapshot<APIResponse<List<NoteForListing>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data?.error == true) {
            return Center(child: Text(snapshot.data!.errorMessage.toString()));
          } else if (snapshot.data!.data!.isEmpty) {
            return const Center(
              child: Text('No Notes'),
            );
          }
          return ListView.separated(
              separatorBuilder: ((context, index) => const Divider(
                    height: 1,
                    color: Colors.green,
                  )),
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {},
                  confirmDismiss: (direction) async {
                    final result = await showDialog(
                        context: context,
                        builder: (ctx) => NoteDelete(
                            noteID: snapshot.data!.data![index].noteId));
                    return result;
                  },
                  background: Container(
                    color: Colors.red,
                    padding: const EdgeInsets.only(left: 16),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) => NoteModify(
                              noteId: snapshot.data!.data![index].noteId)),
                        ),
                      );
                    },
                    title: Text(
                      snapshot.data!.data![index].noteTitle,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    subtitle: Text(
                        'Last edited ${formateDateTime(snapshot.data!.data?[index].latestEditeDateTime ?? snapshot.data!.data![index].createDateTime)}'),
                  ),
                );
              },
              itemCount: snapshot.data!.data!.length);
        },
      ),
    );
  }
}
