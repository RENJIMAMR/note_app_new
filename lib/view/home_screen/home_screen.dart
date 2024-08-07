import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:note_app_new/utils/app_sessions.dart';
import 'package:note_app_new/utils/color_constants.dart';
import 'package:note_app_new/view/DummyDb.dart';
import 'package:note_app_new/view/global_widgets/list_card.dart';
import 'package:note_app_new/view/note_detailing_screen/note_detailing_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var noteBox = Hive.box(AppSessions.NOTEBOX);
  List noteKeys = [];
  int selectedColorIndex = 0;

  TextEditingController lockcontroller1 = TextEditingController();
  GlobalKey<FormState> lockkey1 = GlobalKey<FormState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController title_controller = TextEditingController();
  TextEditingController content_controller = TextEditingController();
  TextEditingController date_controller = TextEditingController();
  @override
  @override
  void initState() {
    // we can't assign a value to the same instance variable in same class, have to create a function ,so done initstate,to get keys and initial values when app starting
    noteKeys = noteBox.keys.toList();
    setState(() {});
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 25,
        ),
        backgroundColor: Colors.grey.shade50,
        onPressed: () {
          //to clear the data of bottom sheet before opening again
          title_controller.clear();
          content_controller.clear();
          date_controller.clear();
          selectedColorIndex = 0;
          _customBottomSheet(
            context,
          );
        },
      ),
      backgroundColor: ColorConstants.MainBlack,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var currentNote = noteBox.get(noteKeys[index]);
                  return InkWell(
                    onTap: () {
                      if (Dummydb.isLock == true) {
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
                                key: lockkey1,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value != null && value.isNotEmpty) {
                                      return null;
                                    } else {
                                      return 'Enter password';
                                    }
                                  },
                                  controller: lockcontroller1,
                                  style:
                                      TextStyle(color: ColorConstants.blueGrey),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (lockkey1.currentState != null &&
                                          lockkey1.currentState!.validate() &&
                                          Dummydb.password ==
                                              lockcontroller1.text) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  NoteDetailingScreen(
                                                      title:
                                                          currentNote['title'],
                                                      content: currentNote[
                                                          'content'],
                                                      date: currentNote['date'],
                                                      bg: Dummydb.colorsList[
                                                          currentNote[
                                                              "colorIndex"]]),
                                            ));
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
                      }
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return NoteDetailingScreen(
                            title: currentNote['title'],
                            content: currentNote['content'],
                            date: currentNote['date'],
                            bg: Dummydb.colorsList[currentNote["colorIndex"]]);
                      }));
                    },
                    child: ListCard(
                      title: currentNote['title'],
                      content: currentNote['content'],
                      date: currentNote['date'],
                      NoteColor: Dummydb.colorsList[currentNote["colorIndex"]],

                      //for deletion
                      onDelete: () {
                        noteBox.delete(noteKeys[index]);
                        noteKeys = noteBox.keys.toList();
                        setState(() {});
                      },
                      //to edit
                      onEdit: () {
                        title_controller.text = currentNote['title'];
                        content_controller.text = currentNote['content'];
                        date_controller.text = currentNote['date'];
                        //we can do this by creating another object like this
                        // title_controller = TextEditingController(
                        //     text: Dummydb.ListCardData[index]['title']);
                        selectedColorIndex = currentNote['colorIndex'];

                        _customBottomSheet(context,
                            isEdit: true, itemIndex: index);
                        setState(() {});
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: 20,
                ),
                itemCount: noteKeys.length,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _customBottomSheet(BuildContext context,
      {bool isEdit = false, itemIndex}) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, addState) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    decoration: BoxDecoration(
                        color: ColorConstants.blueGrey,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(29))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 25, right: 30, left: 30, bottom: 40),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  validator: (title) {
                                    if (title != null && title.isNotEmpty) {
                                      return null;
                                    } else {
                                      return 'title is required';
                                    }
                                  },
                                  controller: title_controller,
                                  decoration: InputDecoration(
                                      filled: true,
                                      hintText: 'Title',
                                      fillColor: ColorConstants.blueGreyLight,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  validator: (content) {
                                    if (content != null && content.isNotEmpty) {
                                      return null;
                                    } else {
                                      return 'content is required';
                                    }
                                  },
                                  controller: content_controller,
                                  decoration: InputDecoration(
                                      filled: true,
                                      hintText: 'Description',
                                      fillColor: ColorConstants.blueGreyLight,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  readOnly: true,
                                  validator: (date) {
                                    if (date != null && date.isNotEmpty) {
                                      return null;
                                    } else {
                                      return 'date is required';
                                    }
                                  },
                                  controller: date_controller,
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          onPressed: () async {
                                            var selectDate =
                                                await showDatePicker(
                                                    initialDatePickerMode:
                                                        DatePickerMode.day,
                                                    context: context,
                                                    firstDate: DateTime(2024),
                                                    lastDate: DateTime.now());
                                            if (selectDate != null) {
                                              date_controller.text =
                                                  DateFormat('dd MMMM, y')
                                                      .format(selectDate);
                                            }
                                          },
                                          icon: Icon(
                                              Icons.calendar_month_outlined)),
                                      filled: true,
                                      hintText: 'Date',
                                      hintMaxLines: 10,
                                      hintStyle: TextStyle(),
                                      fillColor: ColorConstants.blueGreyLight,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: StatefulBuilder(
                                  builder: (context, setColorState) => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: List.generate(
                                        Dummydb.colorsList.length,
                                        (index) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: InkWell(
                                            onTap: () {
                                              setColorState(() {
                                                selectedColorIndex = index;
                                                print(selectedColorIndex);
                                              });
                                            },
                                            child: Container(
                                              height: 50,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                border: selectedColorIndex ==
                                                        index
                                                    ? Border.all(
                                                        width: 3,
                                                        color: ColorConstants
                                                            .Mainwhite)
                                                    : null,
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                color:
                                                    Dummydb.colorsList[index],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ))),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 55, vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 90,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: ColorConstants.Mainwhite,
                                      ),
                                      child: Center(child: Text('Cancel')),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      isEdit
                                          ? noteBox.put(noteKeys[itemIndex!], {
                                              'title': title_controller.text,
                                              'content':
                                                  content_controller.text,
                                              'date': date_controller.text,
                                              'colorIndex': selectedColorIndex
                                            })

                                          //to add new note to hive storage
                                          //step 3
                                          : noteBox.add({
                                              'title': title_controller.text,
                                              'content':
                                                  content_controller.text,
                                              'date': date_controller.text,
                                              'colorIndex': selectedColorIndex,
                                              // 'islock': false,
                                              // 'pass': ''
                                            });
                                      // });
                                      noteKeys = noteBox.keys
                                          .toList(); //to update the key list after add
                                      setState(() {
                                        Navigator.pop(context);
                                      });
                                      // }
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 90,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: ColorConstants.Mainwhite,
                                      ),
                                      child: Center(
                                          child:
                                              Text(isEdit ? 'update' : 'Save')),
                                    ),
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ));
  }
}
