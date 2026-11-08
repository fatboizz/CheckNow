import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/text_styles.dart';
import '../../../data/models/task_model.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_input_field.dart';
import '../../home/controllers/task_controller.dart';

/// Screen allowing the user to create and schedule a new task.
class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.find<TaskController>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _endTime = "9:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now());
  int _selectedRemind = 5;
  String _selectedRepeat = AppConstants.repeatNone;
  int _selectedColor = 0;

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Thêm ghi chú",
                style: headingStyle,
              ),
              CustomInputField(
                title: "Tiêu đề",
                hint: "Nhập tiêu đề ở đây",
                controller: _titleController,
              ),
              CustomInputField(
                title: "Ghi chú",
                hint: "Nhập ghi chú ở đây",
                controller: _noteController,
              ),
              CustomInputField(
                title: "Thời gian",
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: const Icon(Icons.calendar_month_outlined),
                  onPressed: _getDateFromUser,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomInputField(
                      title: "Bắt đầu",
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: () => _getTimeFromUser(isStartTime: true),
                        icon: const Icon(Icons.timer_outlined),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomInputField(
                      title: "Kết thúc",
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: () => _getTimeFromUser(isStartTime: false),
                        icon: const Icon(Icons.timer_outlined),
                      ),
                    ),
                  ),
                ],
              ),
              CustomInputField(
                title: "Nhắc lại",
                hint: "Sau $_selectedRemind phút",
                widget: DropdownButton<String>(
                  icon: const Icon(Icons.keyboard_arrow_down),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: const SizedBox.shrink(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedRemind = int.parse(newValue);
                      });
                    }
                  },
                  items: AppConstants.reminderOptions
                      .map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ),
              CustomInputField(
                title: "Lặp lại",
                hint: " $_selectedRepeat ",
                widget: DropdownButton<String>(
                  icon: const Icon(Icons.keyboard_arrow_down),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: const SizedBox.shrink(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedRepeat = newValue;
                      });
                    }
                  },
                  items: AppConstants.repeatOptions
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Màu sắc", style: titleStyle),
                      const SizedBox(height: 5.0),
                      Wrap(
                        children: List<Widget>.generate(3, (int index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedColor = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: CircleAvatar(
                                radius: 13,
                                backgroundColor: AppColors.getTaskColor(index),
                                child: _selectedColor == index
                                    ? const Icon(
                                        Icons.done,
                                        color: Colors.white,
                                        size: 16,
                                      )
                                    : null,
                              ),
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                  CustomButton(
                    label: "Lưu",
                    onTap: _validateDate,
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _validateDate() {
    if (_titleController.text.trim().isNotEmpty &&
        _noteController.text.trim().isNotEmpty) {
      _addTaskToDB();
      Get.back();
    } else {
      Get.snackbar(
        "Chú ý",
        "Vui lòng điền đầy đủ thông tin!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.red,
        icon: const Icon(
          Icons.warning_amber,
          color: Colors.red,
        ),
      );
    }
  }

  Future<void> _addTaskToDB() async {
    await _taskController.addTask(
      task: Task(
        note: _noteController.text.trim(),
        title: _titleController.text.trim(),
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        remind: _selectedRemind,
        repeat: _selectedRepeat,
        color: _selectedColor,
        isCompleted: 0,
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.surface,
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: const Icon(
          Icons.arrow_back_ios_new,
          size: 24,
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

  Future<void> _getDateFromUser() async {
    final DateTime? pickedDate = await showDatePicker(
      initialDate: _selectedDate,
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _getTimeFromUser({required bool isStartTime}) async {
    final TimeOfDay? pickedTime = await _showTimePicker(isStartTime);

    if (pickedTime != null && mounted) {
      final String formattedTime = pickedTime.format(context);
      setState(() {
        if (isStartTime) {
          _startTime = formattedTime;
        } else {
          _endTime = formattedTime;
        }
      });
    }
  }

  Future<TimeOfDay?> _showTimePicker(bool isStartTime) async {
    final String timeStr = isStartTime ? _startTime : _endTime;
    int hour = 9;
    int minute = 30;
    try {
      final parts = timeStr.split(":");
      hour = int.parse(parts[0]);
      minute = int.parse(parts[1].split(" ")[0]);
    } catch (_) {}

    return await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: TimeOfDay(
        hour: hour,
        minute: minute,
      ),
    );
  }
}

