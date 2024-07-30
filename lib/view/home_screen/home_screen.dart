import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:note_app_new/utils/color_constants.dart';
import 'package:note_app_new/view/DummyDb.dart';
import 'package:note_app_new/view/global_widgets/list_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedColorIndex = 0;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController title_controller = TextEditingController();
  TextEditingController content_controller = TextEditingController();
  TextEditingController date_controller = TextEditingController();
  @override
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
                  if (index < Dummydb.ListCardData.length) {
                    return InkWell(
                      onTap: () {},
                      child: ListCard(
                        NoteColor: Dummydb.colorsList[
                            Dummydb.ListCardData[index]['colorIndex']],
                        onDelete: () {
                          Dummydb.ListCardData.removeAt(index);
                          setState(() {});
                        },
                        onEdit: () {
                          title_controller.text =
                              Dummydb.ListCardData[index]['title'];
                          content_controller.text =
                              Dummydb.ListCardData[index]['content'];
                          date_controller.text =
                              Dummydb.ListCardData[index]['date'];
                          //we can do this by creating another object like this
                          // title_controller = TextEditingController(
                          //     text: Dummydb.ListCardData[index]['title']);
                          selectedColorIndex =
                              Dummydb.ListCardData[index]['colorIndex'];

                          _customBottomSheet(context,
                              isEdit: true, itemIndex: index);
                          setState(() {});
                        },
                        title: Dummydb.ListCardData[index]['title'],
                        content: Dummydb.ListCardData[index]['content'],
                        date: Dummydb.ListCardData[index]['date'],
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: 20,
                ),
                itemCount: Dummydb.ListCardData.length,
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
                        color: Color.fromARGB(255, 63, 72, 81),
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
                                      fillColor:
                                          Color.fromARGB(255, 134, 155, 165),
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
                                      fillColor:
                                          Color.fromARGB(255, 134, 155, 165),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  validator: (date) {
                                    if (date != null && date.isNotEmpty) {
                                      return null;
                                    } else {
                                      return 'date is required';
                                    }
                                  },
                                  controller: date_controller,
                                  decoration: InputDecoration(
                                      filled: true,
                                      hintText: 'Date',
                                      hintMaxLines: 10,
                                      hintStyle: TextStyle(),
                                      fillColor:
                                          Color.fromARGB(255, 134, 155, 165),
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
                                                border:
                                                    selectedColorIndex == index
                                                        ? Border.all(
                                                            width: 3,
                                                            color: Colors.white)
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
                                        color: Colors.white,
                                      ),
                                      child: Center(child: Text('Cancel')),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      isEdit
                                          ? Dummydb.ListCardData[itemIndex!] = {
                                              'title': title_controller.text,
                                              'content':
                                                  content_controller.text,
                                              'date': date_controller.text,
                                              'colorIndex': selectedColorIndex
                                            }
                                          : Dummydb.ListCardData.add({
                                              'title': title_controller.text,
                                              'content':
                                                  content_controller.text,
                                              'date': date_controller.text,
                                              'colorIndex': selectedColorIndex
                                            });
                                      // });
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
                                        color: Colors.white,
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
