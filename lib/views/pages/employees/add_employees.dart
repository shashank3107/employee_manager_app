import 'package:employee_manager_app/core/controller/employee_controller.dart';
import 'package:employee_manager_app/core/models/employee_model.dart';
import 'package:employee_manager_app/core/services/employee_services.dart';
import 'package:employee_manager_app/utils/validator.dart';
import 'package:employee_manager_app/views/pages/home/home_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:get/get.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({Key? key}) : super(key: key);

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final employeeController = Get.put(EmployeeController());
  final _formKey = GlobalKey<FormState>();
  late final EmployeeModel _employeeModel = EmployeeModel();
  RxString buttonText = 'ADD'.obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(20),
                      fillColor: Colors.white,
                      filled: true,
                      labelText: "Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (name) {
                      return name == null || name.length == 0
                          ? 'Required'
                          : null;
                    },
                    onSaved: (val) {
                      _employeeModel.name = val;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(20),
                      fillColor: Colors.white,
                      filled: true,
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) {
                      return isEmaiVAlid(email!) ? null : 'Invalid Email Id';
                    },
                    onSaved: (val) {
                      _employeeModel.email = val;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(20),
                      prefix: Text(
                        "+91",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      labelText: "Mobile Number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (phoneNo) {
                      return phoneNo == null || phoneNo.length == 0
                          ? 'Required'
                          : phoneNo.length < 10 || phoneNo.length > 10
                              ? 'Invalid phone number'
                              : null;
                    },
                    onSaved: (val) {
                      _employeeModel.phoneNo = val;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DateTimePicker(
                    // initialTime: i,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(20),
                      prefix: Row(
                        mainAxisSize: MainAxisSize.min,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.date_range,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      labelText: "Choose Date",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    initialValue: '',
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    dateLabelText: 'Date',
                    // onChanged: (val) {
                    //   print(val);
                    // },

                    validator: (date) {
                      print(date);
                      return date == "" ? 'Required' : null;

                      //return null;
                    },
                    onSaved: (val) =>
                        _employeeModel.dateOfJoining = DateTime.parse(val!),
                  ),
                  MaterialButton(
                    color: Colors.greenAccent,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        buttonText.value = "ADDING";
                        _formKey.currentState!.save();

                        await employeeController.addEmployee(_employeeModel);
                      }
                    },
                    child: Obx(() => Text(buttonText.value)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
