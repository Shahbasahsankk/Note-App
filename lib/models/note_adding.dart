class NoteForAdding {
  final String noteTitle;
  final String noteContent;

  NoteForAdding({
    required this.noteTitle,
    required this.noteContent,
  });

  Map<String, dynamic> toJson() {
    return {
      'noteTitle': noteTitle,
      'noteContent': noteContent,
    };
  }
}
