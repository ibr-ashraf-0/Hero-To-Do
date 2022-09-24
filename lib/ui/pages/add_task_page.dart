import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/ui/size_config.dart';
import 'package:todo_app/ui/theme.dart';
import 'package:todo_app/ui/widgets/button.dart';
import '../../models/task.dart';
import '../../services/theme_services.dart';
import '../widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedData = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();
  int _selctedRemind = 5;

  List<int> remindList = [5, 10, 15, 20];
  String _selctedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];

  int _selctedColor = 1;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: MyAppBar(context),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Add Task',
                    style: headingStyle1,
                  )),
              const SizedBox(
                height: 10,
              ),
              InputField(
                title: 'Title',
                hient: 'Enter title here',
                controller: _titleController,
              ),
              InputField(
                title: 'Note',
                hient: 'Enter note here',
                controller: _noteController,
              ),
              InputField(
                title: 'Date',
                hient: DateFormat.yMd().format(_selectedData),
                child: IconButton(
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () => _getDateFromUser(context),
                ),
              ),
              Row(
                children: [
                  Container(
                    width: SizeConfig.screenWidth / 2.10,
                    child: InputField(
                      title: 'Start Time',
                      hient: _startTime,
                      child: IconButton(
                        icon: const Icon(
                          Icons.access_time_outlined,
                          color: Colors.grey,
                        ),
                        onPressed: () => _getTimeFromUser(isStartTime: true, context: context),
                      ),
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth / 2.10,
                    child: InputField(
                      title: 'End Time',
                      hient: _endTime,
                      child: IconButton(
                        icon: const Icon(
                          Icons.access_time_outlined,
                          color: Colors.grey,
                        ),
                        onPressed: () => _getTimeFromUser(isStartTime: false, context: context),
                      ),
                    ),
                  ),
                ],
              ),
              InputField(
                  title: 'Remind',
                  hient: '$_selctedRemind minutes early',
                  child: DropdownButton<dynamic>(
                    dropdownColor: orangeClr,
                    borderRadius: BorderRadius.circular(15),
                    icon: Container(
                        width: 55,
                        alignment: Alignment.topCenter,
                        child: const Icon(
                          Icons.keyboard_arrow_down_outlined,
                          size: 40,
                          color: Colors.grey,
                        )),
                    underline: const SizedBox(
                      height: 0,
                      width: 0,
                    ),
                    items: remindList.map<DropdownMenuItem<String>>((int item) {
                      return DropdownMenuItem<String>(
                          value: item.toString(),
                          child: Text(
                            item.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selctedRemind = int.parse(value.toString());
                      });
                    },
                  )),
              InputField(
                  title: 'Repeat',
                  hient: _selctedRepeat,
                  child: DropdownButton<dynamic>(
                    dropdownColor: pinkClr,
                    borderRadius: BorderRadius.circular(15),
                    icon: Container(
                        width: 55,
                        alignment: Alignment.topCenter,
                        child: const Icon(
                          Icons.keyboard_arrow_down_outlined,
                          size: 40,
                          color: Colors.grey,
                        )),
                    underline: const SizedBox(
                      height: 0,
                      width: 0,
                    ),
                    items:
                        repeatList.map<DropdownMenuItem<String>>((String item) {
                      return DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selctedRepeat = value;
                      });
                    },
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: Text('Color',
                              style: titleStyle, textAlign: TextAlign.start)),
                      _colorPalette(),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: MyButton(label: 'Create Task', onPressed: ()=> _validteDate()),
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }

 void _validteDate(){
   if(_titleController.text.isNotEmpty && _noteController.text.isNotEmpty){
      _addTaskToDB();
      Get.back();
    }else if (_titleController.text.isEmpty || _noteController.text.isEmpty){
      Get.snackbar('required',
          'Title and Note can\'t be null',
      snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.isDarkMode ? Colors.white : Colors.grey[400],
        colorText: Colors.red,
        icon: const Icon(Icons.warning_amber_rounded,color: Colors.red,),
      );
    }
}

 _addTaskToDB() async{
 try{
    await _taskController.addTask(
     task: Task(
       title: _titleController.text,
       color: _selctedColor,
       endTime: _endTime,
       note: _noteController.text,
       isCompleted: 0,
       date: DateFormat.yMd().format(_selectedData),
       remind: _selctedRemind,
       repeat: _selctedRepeat,
       startTime: _startTime,
     ),
   );
 }catch (e){
   debugPrint('Eroorrrr $e');
 }
  }
  AppBar MyAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).canvasColor,
      elevation: 0.0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: ThemeServices().currentTheme == ThemeMode.light
              ? primaryClr
              : Colors.black,
        ),
        onPressed: () => Get.back(),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 20,top: 15),
          child: CircleAvatar(
            backgroundImage: AssetImage('images/person.jpeg'),
            radius: 20,
          ),
        ),
      ],
    );
  }

  Container _colorPalette() {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      child: Row(
        children: List.generate(
          3,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                _selctedColor = index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: CircleAvatar(
                backgroundColor: index == 0
                    ? bluishClr
                    : index == 1
                        ? orangeClr
                        : pinkClr,
                radius: 17,
                child: _selctedColor == index
                    ? const Icon(
                        Icons.check,
                        size: 24,
                        color: Colors.white,
                      )
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _getTimeFromUser({required bool isStartTime ,required BuildContext context}) async {
    debugPrint('start Time is ${_startTime.toString()}');
    debugPrint('end Time is ${_endTime.toString()}');
    TimeOfDay? _pickedTime = await showTimePicker(
      context: context,
      initialTime: isStartTime ?TimeOfDay.fromDateTime(DateTime.now()) : TimeOfDay.fromDateTime(DateTime.now().add(const Duration(minutes: 15))),
    );
    if(_pickedTime != null) {
      debugPrint('pickedTime is ${_pickedTime.toString()}');
      String formttedTime = _pickedTime.format(context);
      debugPrint('formttedTime is ${formttedTime.toString()}');
      if (isStartTime) {
        setState(() {
          _startTime = formttedTime;
        });
      }
      else if (!isStartTime) {
        setState(() {
          _endTime = formttedTime;
        });
      }
    }else{
      debugPrint('Not selcted Time');
    }
  }

  _getDateFromUser(context)async {
    DateTime? _pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedData,
      firstDate: DateTime(2015),
      lastDate: DateTime(2030),
    );
    if (_pickedDate != null) {
      setState(() {
        _selectedData = _pickedDate;
      });
    }else{
      debugPrint('Not selcted Date');
    }
  }
}
