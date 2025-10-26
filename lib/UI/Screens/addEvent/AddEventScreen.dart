import 'package:events/UI/Common/CustonFormField.dart';
import 'package:events/UI/Common/events-tabs.dart';
import 'package:events/UI/Provider/AppAuthProvider.dart';
import 'package:events/database/EventsDao.dart';
import 'package:events/database/model/Category.dart';
import 'package:events/database/model/events.dart';
import 'package:events/extensions/context-extension.dart';
import 'package:events/extensions/date-time-extension.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class AddEventScreen extends StatefulWidget {
  AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  int selectedTabIndex = 0;
  List<Category> allCategories = Category.getCategories(includeAll: false);
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Event'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SingleChildScrollView(
                child: Column(
                  spacing: 16,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image(image: AssetImage(
                            Category.getCategoryImage(allCategories[selectedTabIndex].id)
                        ))),
                    EventsTabs(
                      allCategories,
                      reversed: true,
                      selectedTabIndex,
                          (index, category) {
                        setState(() {
                          selectedTabIndex = index;
                        });
                      },),

                    AppFormField(
                      controller: titleController,
                      label: "Event Title", icon: Icons.edit,
                      validator: (text) {
                        if(text == null || text.trim().isEmpty){
                          return "please enter title";
                        }
                      },),
                    AppFormField(
                      controller: descriptionController,
                      label: "Description",
                      lines: 5,
                      validator: (text) {
                        if(text == null || text.trim().isEmpty){
                          return "please enter description";
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.date_range_outlined),
                            Text("Event Date",
                              style: context.fonts.bodyMedium?.copyWith(
                                  color: Colors.black
                              ),),
                          ],
                        ),
                        TextButton(
                          onPressed: (){
                            chooseDate();
                          },
                          child: Text(
                            selectedDate == null? "Choose Date":
                            selectedDate?.format() ?? ""
                            ,
                            style: context.fonts.bodyMedium?.copyWith(
                              color: context.appColors.primary,
                            ),),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.timer_outlined),
                            Text("Event time" ,
                              style: context.fonts.bodyMedium?.copyWith(
                                  color: Colors.black
                              ),),
                          ],
                        ),
                        TextButton(
                          onPressed: (){
                            chooseTime();
                          },
                          child: Text(
                            selectedTime == null? "Choose time":
                            selectedTime?.format(context)??""
                            ,
                            style: context.fonts.bodyMedium?.copyWith(
                              color: context.appColors.primary,
                            ),),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              ElevatedButton(onPressed: (){
                createEvent();
              }, child: Text("Add Event"))

            ],
          ),
        ),
      ),
    );
  }

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  void chooseDate() async {
    var date = await showDatePicker(context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 60)));
    setState(() {
      selectedDate = date;
    });
  }
  void chooseTime() async {
    var time = await showTimePicker(context: context,
      initialTime: TimeOfDay.now(),
    );
    setState(() {
      selectedTime = time;
    });
  }
  bool isValidData(){
    var isValid = formKey.currentState?.validate() ?? false;
    if(selectedDate == null){
      // show error message
      context.showMessageDialog("please Choose Event Date",);
      isValid = false;
    }
    else if(selectedTime == null){
      // show error message
      context.showMessageDialog("please Choose Event time",);
      isValid = false;
    }
    return isValid;
  }
  void createEvent() async{
    if(!isValidData()){
      return;
    }

    // show Loading Dialog
    var authProvider =Provider.of<AppAuthProvider>(context,listen: false);
    var event = Event(
      title: titleController.text,
      desc: descriptionController.text,
      date: selectedDate,
      time: selectedTime?.toDateTime(),
      categoryId: allCategories[selectedTabIndex].id,
      creatorUserId: authProvider.getUser()?.id,
    ) ;
    context.showLoadingDialog(
        message: "Creating Event ...",isDismissible: false
    );
    await EventsDao.addEvent(event);
    // hideLoading Dialog
    Navigator.pop(context);
    context.showMessageDialog("Event Created Successfully",
      posActionText: "ok",
      onPosActionClick: (){
        Navigator.pop(context);
      },
      isDismissible: false,
    );
  }
}