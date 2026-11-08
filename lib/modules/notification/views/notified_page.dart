import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Screen displayed when user taps on a task notification.
class NotifiedPage extends StatelessWidget {
  final String? label;

  const NotifiedPage({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final List<String> parts = label?.split("|") ?? ["Thông báo", "Nội dung"];
    final String title = parts.isNotEmpty ? parts[0] : "Thông báo";
    final String message = parts.length > 1 ? parts[1] : "";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? Colors.grey[800] : Colors.blue,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Get.isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          height: 400,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Get.isDarkMode ? Colors.grey[850] : Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                spreadRadius: 5.0,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.notification_important,
                size: 60,
                color: Get.isDarkMode ? Colors.redAccent : Colors.blueAccent,
              ),
              const SizedBox(height: 20),
              Text(
                message,
                style: TextStyle(
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

