import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/services/notification_service.dart';
import 'core/services/theme_service.dart';
import 'core/theme/app_theme.dart';
import 'data/providers/db_provider.dart';
import 'modules/home/controllers/task_reset_scheduler.dart';
import 'modules/home/views/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBProvider.initDb();
  await NotificationHelper.init();
  await GetStorage.init();

  // Schedule daily reset for recurring tasks
  TaskResetScheduler.scheduleDailyReset();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CheckNow',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      themeMode: ThemeService().theme,
      home: const HomePage(),
    );
  }
}
