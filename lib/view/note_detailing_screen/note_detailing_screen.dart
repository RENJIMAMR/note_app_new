import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:note_app_new/utils/color_constants.dart';
import 'package:note_app_new/view/DummyDb.dart';

class NoteDetailingScreen extends StatefulWidget {
  const NoteDetailingScreen({
    super.key,
    required this.title,
    required this.content,
    required this.date,
    required this.bg,
    // this.islocked,
    // this.lockAlert
  });
  final String title, content, date;
  // final bool? islocked;
  final Color bg;
  // final void Function()? lockAlert;
  @override
  State<NoteDetailingScreen> createState() => _NoteDetailingScreenState();
}

class _NoteDetailingScreenState extends State<NoteDetailingScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController lockcontroller = TextEditingController();
    GlobalKey<FormState> lockkey = GlobalKey<FormState>();

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
          StatefulBuilder(
            builder: (context, setState) => PopupMenuButton(
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
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                'Enter master password',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              actions: [
                                Form(
                                  key: lockkey,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value != null && value.isNotEmpty) {
                                        return null;
                                      } else {
                                        return 'Enter password';
                                      }
                                    },
                                    controller: lockcontroller,
                                    style: TextStyle(
                                        color: ColorConstants.blueGrey),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (lockkey.currentState != null &&
                                            lockkey.currentState!.validate()) {
                                          Dummydb.password =
                                              lockcontroller.text;
                                          Navigator.pop(context);
                                          Dummydb.isLock = true;
                                          setState(() {});
                                        }
                                      },
                                      child: Text(
                                        'Ok',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: ColorConstants.blueGrey),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
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
                    ]),
          )

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
