class NoteForListing {
  final String noteId;
  final String noteTitle;
  final DateTime createDateTime;
  final DateTime latestEditeDateTime;

  NoteForListing({
    required this.noteId,
    required this.noteTitle,
    required this.createDateTime,
    required this.latestEditeDateTime,
  });
  factory NoteForListing.fromJson(Map<String, dynamic> json) {
    return NoteForListing(
      noteId: json['noteID'],
      noteTitle: json['noteTitle'],
      createDateTime: DateTime.parse(json['createDateTime']),
      latestEditeDateTime: json['latestEditDateTime'] != null
          ? DateTime.parse(json['latestEditDateTime'])
          : DateTime.parse(json['createDateTime']),
    );
  }
}

class SingleNote {
  final String noteId;
  final String noteTitle;
  final String noteContent;
  final DateTime createDateTime;
  final DateTime latestEditeDateTime;

  SingleNote({
    required this.noteId,
    required this.noteTitle,
    required this.noteContent,
    required this.createDateTime,
    required this.latestEditeDateTime,
  });
  factory SingleNote.fromJson(Map<String, dynamic> json) {
    return SingleNote(
      noteId: json['noteID'],
      noteTitle: json['noteTitle'],
      createDateTime: DateTime.parse(json['createDateTime']),
      latestEditeDateTime: json['latestEditDateTime'] != null
          ? DateTime.parse(json['latestEditDateTime'])
          : DateTime.parse(json['createDateTime']),
      noteContent: json['noteContent'],
    );
  }
}
