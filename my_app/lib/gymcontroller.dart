// controllers/home_controller.dart
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:my_app/Tablescreen.dart';
import 'package:my_app/auth.dart';
import 'package:my_app/gymtable.dart';
import 'package:my_app/mypage.dart';

class Gymcontroller extends GetxController {
  // Store selected date
  Rx<DateTime?> selectedDate = Rx<DateTime?>(DateTime.now());
  final AuthController authController = Get.find();
  late List<String> gymnames = [
    "Venkatesh",
    "Vamsi",
    "Ashok",
  ];
  late List<String> gymworks = ["Dish Wash", "Protien", "Free"];
  // TextField controller
  TextEditingController textFieldController = TextEditingController();

  // Method to pick a date
  Future<void> selectDategym(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
    }
  }

  // Method to calculate the week number
  int getWeekNumbergym(DateTime date) {
    DateTime firstDayOfYear = DateTime(date.year, 1, 1);
    int daysSinceStartOfYear = date.difference(firstDayOfYear).inDays;
    return ((daysSinceStartOfYear + firstDayOfYear.weekday) / 7).ceil();
  }

  getwork(int weeknumber) {
    gymnames = [
      "Venkatesh",
      "Vamsi",
      "Ashok",
    ];
    int wd = weeknumber - 50;
    int a = wd % 3;
    int s = 0;
    print(a);
    while (s != a) {
      String t = gymnames[2];
      for (int i = 2; i > 0; i--) {
        gymnames[i] = gymnames[i - 1];
      }
      gymnames[0] = t;
      s = s + 1;
    }
  }

  // Method to handle form submission
  void submitData(BuildContext context, String flag) {
    if (flag == "1") {
      selectedDate = Rx<DateTime?>(DateTime.now());
    }
    print("this");
    print(selectedDate);
    print(Rx<DateTime?>(DateTime.now()));
    if (selectedDate.value != null) {
      String formattedDate =
          "${selectedDate.value!.day}/${selectedDate.value!.month}/${selectedDate.value!.year}";
      String textFieldData = textFieldController.text;
      getwork(getWeekNumbergym(selectedDate.value!));
      print("Date: $formattedDate");
      print(getWeekNumbergym(selectedDate.value!));
      if (flag == "1") {
        Get.to(GymTable());
      } else {
        Get.to(GymTable());
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data Submitted! Navigating to the table...'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a date and enter text!'),
        ),
      );
    }
  }

  getindex() {
    int index = gymnames.indexOf(authController.name);
    authController.mywork = gymworks[index];
  }
}
