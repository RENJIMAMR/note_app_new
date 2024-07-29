import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteDetailingScreen extends StatefulWidget {
  const NoteDetailingScreen(
      {super.key,
      required this.title,
      required this.content,
      required this.date,
      this.onDelete,
      this.onEdit});
  final String title, content, date;
  final void Function()? onDelete;
  final void Function()? onEdit;
  @override
  State<NoteDetailingScreen> createState() => _NoteDetailingScreenState();
}

class _NoteDetailingScreenState extends State<NoteDetailingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 234, 226, 154),
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Icon(
            Icons.edit,
            size: 30,
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.more_vert,
            size: 30,
          ),
        ],
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
