// import 'package:flutter/material.dart';
// import 'package:note_app_new/utils/color_constants.dart';
// import 'package:note_app_new/view/DummyDb.dart';
// import 'package:note_app_new/view/global_widgets/list_card.dart';

// class NoteScreen extends StatefulWidget {
//   const NoteScreen({super.key});

//   @override
//   State<NoteScreen> createState() => _NoteScreenState();
// }

// class _NoteScreenState extends State<NoteScreen> {
//   GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   TextEditingController titleController = TextEditingController();
//   TextEditingController contentController = TextEditingController();
//   TextEditingController dateController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         child: Icon(
//           Icons.add,
//           size: 25,
//         ),
//         backgroundColor: Colors.grey.shade50,
//         onPressed: () {
//           showModalBottomSheet(
//             isScrollControlled: true,
//             context: context,
//             builder: (context) => StatefulBuilder(
//               builder: (context, addState) {
//                 return Container(
//                   decoration: BoxDecoration(
//                     color: Color.fromARGB(255, 63, 72, 81),
//                     borderRadius: BorderRadius.vertical(
//                       top: Radius.circular(29),
//                     ),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                       top: 25,
//                       right: 30,
//                       left: 30,
//                       bottom: 40,
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Form(
//                           key: _formKey,
//                           child: Column(
//                             children: [
//                               TextFormField(
//                                 validator: (title) {
//                                   if (title == null || title.isEmpty) {
//                                     return 'Title is required';
//                                   }
//                                   return null;
//                                 },
//                                 controller: titleController,
//                                 decoration: InputDecoration(
//                                   filled: true,
//                                   hintText: 'Title',
//                                   fillColor: Color.fromARGB(255, 134, 155, 165),
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(height: 20),
//                               TextFormField(
//                                 validator: (content) {
//                                   if (content == null || content.isEmpty) {
//                                     return 'Description is required';
//                                   }
//                                   return null;
//                                 },
//                                 controller: contentController,
//                                 decoration: InputDecoration(
//                                   filled: true,
//                                   hintText: 'Description',
//                                   fillColor: Color.fromARGB(255, 134, 155, 165),
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(height: 20),
//                               TextFormField(
//                                 validator: (date) {
//                                   if (date == null || date.isEmpty) {
//                                     return 'Date is required';
//                                   }
//                                   return null;
//                                 },
//                                 controller: dateController,
//                                 decoration: InputDecoration(
//                                   filled: true,
//                                   hintText: 'Date',
//                                   fillColor: Color.fromARGB(255, 134, 155, 165),
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 5),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 height: 50,
//                                 width: 60,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(7),
//                                   color: Color.fromARGB(255, 134, 155, 165),
//                                 ),
//                               ),
//                               Container(
//                                 height: 50,
//                                 width: 60,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(7),
//                                   color: Color.fromARGB(255, 103, 156, 180),
//                                 ),
//                               ),
//                               Container(
//                                 height: 50,
//                                 width: 60,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(7),
//                                   color: Color.fromARGB(255, 158, 165, 134),
//                                 ),
//                               ),
//                               Container(
//                                 height: 50,
//                                 width: 60,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(7),
//                                   color: Color.fromARGB(255, 165, 134, 153),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 55, vertical: 5),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               InkWell(
//                                 onTap: () {
//                                   Navigator.pop(context);
//                                 },
//                                 child: Container(
//                                   height: 40,
//                                   width: 90,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(7),
//                                     color: Colors.white,
//                                   ),
//                                   child: Center(child: Text('Cancel')),
//                                 ),
//                               ),
//                               InkWell(
//                                 onTap: () {
//                                   if (_formKey.currentState?.validate() ??
//                                       false) {
//                                     addState(() {
//                                       Dummydb.ListCardData.add({
//                                         'title': titleController.text,
//                                         'content': contentController.text,
//                                         'date': dateController.text,
//                                       });
//                                     });
//                                     Navigator.pop(context);
//                                     setState(() {});
//                                   }
//                                 },
//                                 child: Container(
//                                   height: 40,
//                                   width: 90,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(7),
//                                     color: Colors.white,
//                                   ),
//                                   child: Center(child: Text('Save')),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//       backgroundColor: ColorConstants.MainBlack,
//       body: ListView.separated(
//         padding: const EdgeInsets.all(20.0),
//         itemBuilder: (context, index) {
//           if (index < Dummydb.ListCardData.length) {
//             return ListCard(
//               title: Dummydb.ListCardData[index]['title'],
//               content: Dummydb.ListCardData[index]['content'],
//               date: Dummydb.ListCardData[index]['date'],
//             );
//           }
//           return Container(); // Return an empty container for safety
//         },
//         separatorBuilder: (context, index) => SizedBox(height: 20),
//         itemCount: Dummydb.ListCardData.length,
//       ),
//     );
//   }
// }
