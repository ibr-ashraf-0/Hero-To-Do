import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../db/db_helper.dart';
import '../../services/notification_services.dart';
import 'add_task_page.dart';
import '../size_config.dart';
import '../../controllers/task_controller.dart';
import '../../models/task.dart';
import '../../services/theme_services.dart';
import '../../ui/widgets/button.dart';
import '../theme.dart';
import '../widgets/task_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}
RxList<Task> taskDate = _taskController.taskList;
String selectedDataformat = DateFormat.yMd().format(_selectedData);
final TaskController _taskController = Get.put(TaskController());

DateTime _selectedData = DateTime.now();

class _HomePageState extends State<HomePage> {
  late NotifyHelper notifyHelper;
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
   notifyHelper.requestIOSPermissions();
   notifyHelper.initializeNotification();
   _taskController.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor:
          Get.isDarkMode ? context.theme.backgroundColor : Colors.white,
      appBar: myAppBar(context),
      body: SafeArea(
        child: Column(
          children: [
            _addTaskBar(),
            _addDataBar(),
            _showTasks(),
          ],
        ),
      ),
    );
  }

  AppBar myAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: context.theme.backgroundColor,
      centerTitle: true,
      leading: IconButton(
        icon: Get.isDarkMode
            ? const Icon(
                Icons.wb_sunny_outlined,
                color: Colors.white,
              )
            : const Icon(
                Icons.nightlight_round_outlined,
                color: darkGreyClr,
              ),
        onPressed: () {
          ThemeServices().switchTheme();
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: IconButton(
            icon : Icon(Icons.cleaning_services,
            color: Get.isDarkMode ? primaryClr : Colors.white,
            ),
            onPressed: (){
              DBHelper.deleteAll();
              notifyHelper.cancelAllNotification();
            },
          )
        ),
        const Padding(
          padding: EdgeInsets.only(right: 20),
          child: CircleAvatar(
            backgroundImage: AssetImage('images/person.jpeg'),
            radius: 20,
          ),
        ),
      ],
    );
  }

  Widget _addTaskBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()).toString(),
                style: subHeadingStyle,
              ),
              Text(
                'Today',
                style: headingStyle1,
              ),
            ],
          ),
          MyButton(
              label: '+  Add Task',
              onPressed: () async {
                await Get.to(const AddTaskPage());
              })
        ],
      ),
    );
  }

  Widget _addDataBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: DatePicker(
        DateTime.now(),
        initialSelectedDate: DateTime.now(),
        onDateChange: (newDate) {
          setState(() {
            _selectedData = newDate;
          });
        },
        width: 70,
        height: 100,
        selectionColor: primaryClr,
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        selectedTextColor: Colors.white,
      ),
    );
  }

   Widget _showTasks() {
    if (taskDate.isEmpty || taskDate[0].date != selectedDataformat) {
      return Expanded(child: _noTaskMsg());
    } else{
      return Expanded(
        child: Obx(() {
          return RefreshIndicator(
            onRefresh: () => _onRefresh(),
            child: ListView.builder(
              scrollDirection: SizeConfig.orientation == Orientation.landscape
                  ? Axis.horizontal
                  : Axis.vertical,
              itemCount: _taskController.taskList.length,
              itemBuilder: (context, index) {
                Task task = _taskController.taskList[index];
                DateTime date = DateFormat.jm().parse(task.startTime!);
                String myTime = DateFormat('HH:mm').format(date);
                notifyHelper.scheduledNotification(
                  int.parse(myTime.split(':')[0]),
                  int.parse(myTime.toString().split(':')[1]),
                  task,
                );
                if ((task.repeat == 'Daily' ||
                    task.date == DateFormat.yMd().format(_selectedData)) ||
                    (task.repeat == 'Weekly' && _selectedData
                        .difference(DateFormat.yMd().parse(task.date!))
                        .inDays % 7 == 0) ||
                    (task.repeat == 'Monthly' && DateFormat
                        .yMd()
                        .parse(task.date!)
                        .day == _selectedData.day)
                ) {
                  return AnimationConfiguration.staggeredList(
                    duration: const Duration(milliseconds: 1200),
                    position: index,
                    child: SlideAnimation(
                      horizontalOffset: 300,
                      child: FadeInAnimation(
                        child: GestureDetector(
                          onTap: () => _showButtonSheet(context, task),
                          child: TaskTile(task),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          );
        },
        ),
      );
    }
  }

  Widget _noTaskMsg() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(minutes: 3000),
          child: RefreshIndicator(
            onRefresh: ()=> _onRefresh(),
            child: SingleChildScrollView(
              child: Wrap(
                direction: SizeConfig.orientation != Orientation.landscape
                    ? Axis.horizontal
                    : Axis.vertical,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    height: SizeConfig.orientation == Orientation.landscape ? 6 : SizeConfig.screenHeight * 0.05,
                  ),
                  SvgPicture.asset(
                    'images/task.svg',
                    width: SizeConfig.screenWidth * 0.7,
                    color: primaryClr.withOpacity(0.7),
                    semanticsLabel: 'No Task',
                  ),
                  Container(
                    margin:const EdgeInsets.symmetric(vertical: 50),
                    child: Text(
                      'You do not have any tasks yet!\n Add new tasks to make your days productive',
                      textAlign: TextAlign.center,
                      style: titleStyle,
                    ),
                  ),
                  Container(
                    height:
                        SizeConfig.orientation == Orientation.landscape ? 120 : SizeConfig.screenHeight * 0.15,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildBottonSheet({required String label, required Function() onTap,
  required Color color, bool isClose = false}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 9),
        height: 65,
        width: SizeConfig.screenWidth *0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose ? (Get.isDarkMode ? Colors.grey[600]! : Colors.grey[300]!) : color,
          ),
              borderRadius: BorderRadius.circular(20),
        color: isClose ? Colors.transparent : color,
        ),
        child: Center(
          child: Text(
            label,
            style: isClose? titleStyle : titleStyle.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  _showButtonSheet(BuildContext context, Task task){
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 4),
          width: SizeConfig.screenWidth,
          height: (SizeConfig.orientation == Orientation.landscape)?
          (task.isCompleted == 1 ? SizeConfig.screenHeight * 0.6 : SizeConfig.screenHeight * 0.8)
          :(task.isCompleted == 1 ? SizeConfig.screenHeight * 0.30 : SizeConfig.screenHeight * 0.39),
          color: Get.isDarkMode ? darkHeaderClr : Colors.white,
          child: Column(
            children: [
              Flexible(
                child: Container(
                  height: 6,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Get.isDarkMode ? Colors.grey[600]: Colors.grey[300],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              task.isCompleted == 1 ? Container() : _buildBottonSheet(
                  label: 'Task Completed',
                  onTap: (){
                    _taskController.markUsCompleted(id: task.id!);
                    notifyHelper.cancelNotification(task);
                    Get.back();
                  },
                  color: primaryClr),
              _buildBottonSheet(
                label: 'Delete Completed',
                onTap: (){
                 _taskController.deleteTasks(task : task);
                 notifyHelper.cancelNotification(task);
                 Get.back();
                },
                color: Colors.red[300]!,
              ),
               Divider(color: Get.isDarkMode ? Colors.grey : darkGreyClr,),
              _buildBottonSheet(
                label: 'Cancel',
                onTap: (){
                  Get.back();
                },
                color: primaryClr,),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      )
    );
  }

  Future<void> _onRefresh() {
    taskDate;
    selectedDataformat;
   return _taskController.getTasks();
  }
}
