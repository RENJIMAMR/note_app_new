import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteDetailingScreen extends StatefulWidget {
  const NoteDetailingScreen(
      {super.key,
      required this.title,
      required this.content,
      required this.date,
      required this.bg});
  final String title, content, date;

  final Color bg;

  @override
  State<NoteDetailingScreen> createState() => _NoteDetailingScreenState();
}

class _NoteDetailingScreenState extends State<NoteDetailingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.bg.withOpacity(.7),
      appBar: AppBar(
        backgroundColor: widget.bg,
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        actions: [
          Icon(
            Icons.edit,
            size: 30,
          ),
          SizedBox(
            width: 20,
          ),
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Revert')
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.notifications),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Reminder')
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.send),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Send')
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.lock),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Lock')
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.assignment_returned_rounded),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Archive')
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.delete),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Delete')
                        ],
                      ),
                    ),
                  ])
          // Icon(
          //   Icons.more_vert,
          //   size: 30,
          // ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.date,
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Text(
                widget.content,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 200,
                textAlign: TextAlign.justify,
              ),
            )),
            // SizedBox(height: 80,)
          ],
        ),
      ),
    );
  }
}
