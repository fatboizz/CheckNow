import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/services/notification_service.dart';
import '../../../core/services/theme_service.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/date_time_utils.dart';
import '../../../data/models/task_model.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../add_task/views/add_task_page.dart';
import '../controllers/task_controller.dart';
import '../widgets/task_tile.dart';

/// Main home dashboard displaying scheduled tasks by date.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  final TaskController _taskController = Get.put(TaskController());

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('vi', null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          const SizedBox(height: 10),
          _showTasks(),
        ],
      ),
    );
  }

  Widget _showTasks() {
    return Expanded(
      child: Obx(() {
        final List<Task> filteredTasks = _taskController.taskList.where((task) {
          return DateTimeUtils.isTaskScheduledForDate(
            selectedDate: _selectedDate,
            taskDateStr: task.date,
            repeat: task.repeat,
          );
        }).toList();

        if (filteredTasks.isEmpty) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.assignment_turned_in_outlined,
                    size: 80,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Không có nhiệm vụ nào hôm nay!",
                    style: subTitleStyle,
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: filteredTasks.length,
          itemBuilder: (_, index) {
            final Task task = filteredTasks[index];
            _scheduleTaskNotificationsIfNeeded(task);
            return _buildTaskItem(task, index);
          },
        );
      }),
    );
  }

  Widget _buildTaskItem(Task task, int index) {
    return AnimationConfiguration.staggeredList(
      position: index,
      child: SlideAnimation(
        child: FadeInAnimation(
          child: GestureDetector(
            onTap: () => _showBottomSheet(context, task),
            child: TaskTile(task),
          ),
        ),
      ),
    );
  }

  void _scheduleTaskNotificationsIfNeeded(Task task) {
    if (task.startTime != null && task.startTime!.isNotEmpty) {
      try {
        final startDate = DateFormat("hh:mm a").parse(task.startTime!);
        final startMyTime = DateFormat("HH:mm").format(startDate);
        NotificationHelper.scheduleStartNotification(startMyTime, task);

        if (task.remind != null && task.remind! > 0) {
          NotificationHelper.scheduleRepeatNotification(task, task.remind!);
        }
      } catch (_) {}
    }

    if (task.endTime != null && task.endTime!.isNotEmpty) {
      try {
        final endDate = DateFormat("hh:mm a").parse(task.endTime!);
        final endMyTime = DateFormat("HH:mm").format(endDate);
        NotificationHelper.scheduleEndNotification(endMyTime, task);
      } catch (_) {}
    }
  }

  void _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4),
        height: task.isCompleted == 1
            ? MediaQuery.of(context).size.height * 0.24
            : MediaQuery.of(context).size.height * 0.32,
        color: Get.isDarkMode ? AppColors.darkGreyCls : Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
              ),
            ),
            const Spacer(),
            if (task.isCompleted != 1)
              _bottomSheetButton(
                label: "Đã hoàn thành",
                onTap: () {
                  if (task.id != null) {
                    _taskController.markTaskCompleted(task.id!);
                  }
                  Get.back();
                },
                clr: AppColors.primaryClr,
                context: context,
              ),
            _bottomSheetButton(
              label: "Xóa",
              onTap: () {
                _taskController.delete(task);
                Get.back();
              },
              clr: Colors.red[300]!,
              context: context,
            ),
            const SizedBox(height: 10),
            _bottomSheetButton(
              label: "Đóng",
              onTap: () => Get.back(),
              clr: Colors.white,
              isClose: true,
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomSheetButton({
    required String label,
    required VoidCallback onTap,
    required Color clr,
    bool isClose = false,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose
                ? (Get.isDarkMode ? Colors.grey[600]! : Colors.grey[300]!)
                : clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            label,
            style: isClose
                ? titleStyle
                : titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 110,
        width: 90,
        initialSelectedDate: DateTime.now(),
        selectionColor: AppColors.primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
        locale: 'vi',
      ),
    );
  }

  Widget _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMd('vi').format(DateTime.now()),
                style: subHeadingStyle,
              ),
              Text(
                "Hôm nay",
                style: headingStyle,
              ),
            ],
          ),
          CustomButton(
            label: "+ Thêm ghi chú",
            onTap: () async {
              await Get.to(() => const AddTaskPage());
              _taskController.getTask();
            },
          ),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.surface,
      leading: GestureDetector(
        onTap: _toggleTheme,
        child: Icon(
          Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight,
          size: 26,
        ),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage(AppAssets.userAvatar),
        ),
        SizedBox(width: 20),
      ],
    );
  }

  void _toggleTheme() {
    ThemeService().switchTheme();
    NotificationHelper.pushNotification(
      title: 'Giao diện',
      body: Get.isDarkMode ? "Chế độ sáng" : "Chế độ tối",
    );
  }
}

