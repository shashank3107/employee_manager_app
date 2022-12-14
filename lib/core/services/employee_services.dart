import 'dart:convert';
import 'dart:io';

import 'package:employee_manager_app/core/models/employee_model.dart';
import 'package:employee_manager_app/utils/constants.dart';
import 'package:http/http.dart' as http;

import 'api_status.dart';

class EmployeeServices {
  static Future<Object> getEmployees() async {
    try {
      print("try");
      var url = Uri.parse(baseUrl);
      print(baseUrl);
      var response = await http.get(url);
      print("Hello: " + response.body);
      if (response.statusCode == 200) {
        return Success(response: employeeModelFromJson(response.body));
      }
      return Failure(
          code: userInvalidResponse, errorResponse: 'Invalid Response');
    } on HttpException {
      return Failure(code: noInternet, errorResponse: 'No Internet');
    } on FormatException {
      return Failure(code: invalidFormat, errorResponse: 'Invalid Fomat');
    } catch (e) {
      return Failure(code: unknownError, errorResponse: 'Unknown Error');
    }
  }

  static Future<Object> deleteEmployees(String id) async {
    try {
      var url = Uri.parse(baseUrl + id);
      print(baseUrl);
      var response = await http.delete(url);

      if (response.statusCode == 200) {
        return Success(response: "Deleted Successfully");
      }
      return Failure(
          code: userInvalidResponse, errorResponse: 'Invalid Response');
    } on HttpException {
      return Failure(code: noInternet, errorResponse: 'No Internet');
    } on FormatException {
      return Failure(code: invalidFormat, errorResponse: 'Invalid Fomat');
    } catch (e) {
      return Failure(code: unknownError, errorResponse: 'Unknown Error');
    }
  }

  static Future<Object> addEmployee(EmployeeModel employeeModel) async {
    Map<String, dynamic> employeeDetails = {
      "name": employeeModel.name,
      "email": employeeModel.email,
      "phoneNo": employeeModel.phoneNo,
      "dateOfJoining": employeeModel.dateOfJoining!.toIso8601String()
    };
    var result;
    try {
      var url = Uri.parse(baseUrl);

      print(employeeModel.name);
      final response = await http.post(url,
          body: jsonEncode(employeeDetails), headers: headersMap);
      result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print("Success");
        return Success(response: jsonDecode(response.body));
      }
      return Failure(
          code: userInvalidResponse, errorResponse: 'Invalid Response');
    } on HttpException {
      return Failure(code: noInternet, errorResponse: 'No Internet');
    } on FormatException {
      return Failure(code: invalidFormat, errorResponse: 'Invalid Fomat');
    } catch (e) {
      return Failure(code: unknownError, errorResponse: 'Unknown Error');
    }
  }
}
