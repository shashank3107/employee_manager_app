import 'package:employee_manager_app/core/models/employee_model.dart';
import 'package:employee_manager_app/core/services/api_status.dart';

import 'package:employee_manager_app/core/services/employee_services.dart';
import 'package:employee_manager_app/views/pages/home/home_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EmployeeController extends GetxController {
  DateTime currentDate = DateTime.now();
  var employees = List<EmployeeModel>.empty().obs;
  RxString buttonText = 'ADD'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEmployees();
  }

  /*
    If else ladder because just subtracting the years will miss boundary conditions i.e 
    Years difference may be 5 but if we consider the month and the day it can get above 5 years
  */
  Color flagColor(DateTime dateTime) {
    bool timeGapIsFiveYears = false;
    if (currentDate.year - dateTime.year > 5) {
      timeGapIsFiveYears = true;
    } else if (currentDate.year - dateTime.year == 5) {
      if (currentDate.month - dateTime.month == 0) {
        if (currentDate.day - dateTime.day > 0) {
          timeGapIsFiveYears = true;
        } else if (currentDate.month - dateTime.month > 0) {
          timeGapIsFiveYears = true;
        }
      }
    }

    return timeGapIsFiveYears
        ? const Color(0xff00FF00)
        : const Color(0xff808080);
  }

  String formatDate(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(dateTime);
    return formatted;
  }

  void deleteEmployees(String id, int index) async {
    var response = await EmployeeServices.deleteEmployees(id);

    if (response is Success) {
      //employees.value = response.response as List<EmployeeModel>;
      employees.removeAt(index);
      Get.snackbar(
        'Deleted',
        'Employee Succesfully Deleted',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    }
    if (response is Failure) {
      print(response.code);
    }
  }

  Future addEmployee(EmployeeModel employeeModel) async {
    buttonText.value = "ADDING";
    var response = await EmployeeServices.addEmployee(employeeModel);

    if (response is Success) {
      var newEmployee =
          EmployeeModel.fromJson(response.response as Map<String, dynamic>);
      print(newEmployee.name);
      employees.add(newEmployee);
      Get.off(() => HomeScreenView());
      print(employees.length);
      Get.snackbar(
        'Added',
        'Employee Succesfully Added',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
      buttonText.value = "ADD";
      //employees.value = response.response as List<EmployeeModel>;
    }

    if (response is Failure) {
      print(response.code);
    }
  }

  void fetchEmployees() async {
    var response = await EmployeeServices.getEmployees();

    if (response is Success) {
      employees.value = response.response as List<EmployeeModel>;
    }
    if (response is Failure) {
      print(response.code);
    }
    // if(response is Failure){
    //   UserError
    // }
  }
}
