import 'package:flutter/material.dart';
import 'package:note_app_new/view/DummyDb.dart';
import 'package:share_plus/share_plus.dart';

class ListCard extends StatelessWidget {
  const ListCard({
    super.key,
    required this.title,
    required this.content,
    required this.date,
    this.onDelete,
    this.onEdit,
    required this.NoteColor,
  });
  final String title, content, date;
  final void Function()? onDelete;
  final void Function()? onEdit;
  final Color NoteColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(29),
        color: NoteColor,
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
                Spacer(),
                InkWell(
                  onTap: onEdit,
                  child: Icon(
                    Icons.edit,
                    size: 30,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: onDelete,
                  child: Icon(
                    Icons.delete,
                    size: 30,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              content,
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Spacer(),
                Text(
                  date,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 30,
                ),
                InkWell(
                  onTap: () {
                    Share.share('$title /n $content /n $date');
                  },
                  child: Icon(
                    Icons.share,
                    size: 30,
                  ),
                ),
              ],
            )
          ],
        ),
        // )
        // ),
      ),
    );
  }
}
