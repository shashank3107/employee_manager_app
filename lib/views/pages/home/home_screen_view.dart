import 'package:employee_manager_app/core/controller/employee_controller.dart';
import 'package:employee_manager_app/utils/constants.dart';
import 'package:employee_manager_app/views/pages/employees/add_employees.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class HomeScreenView extends StatelessWidget {
  HomeScreenView({Key? key}) : super(key: key);

  final employeeController = Get.put(EmployeeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColour,
      body: GetX<EmployeeController>(builder: (controller) {
        return ListView.builder(
            itemCount: controller.employees.length,
            itemBuilder: ((context, index) {
              return SizedBox(
                height: 130,
                child: Card(
                  margin: const EdgeInsets.all(5),
                  elevation: 5,
                  child: ListTile(
                      //  contentPadding: Padding(padding:),
                      leading: Column(
                        children: [
                          CircleAvatar(
                            child: Image.asset(
                              "assets/profile.png",
                              scale: 2,
                            ),
                            // backgroundColor: Colors.red,
                            radius: 45,
                          ),
                        ],
                      ),
                      title: Text(
                        controller.employees[index].name.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      subtitle: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text("id: ${controller.employees[index].id!}"),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                              "DOJ: ${EmployeeController().formatDate(controller.employees[index].dateOfJoining!)}"),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                              "Phone No.: ${controller.employees[index].phoneNo!}"),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                              "Email ID: ${controller.employees[index].email!}"),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.flag,
                            color: EmployeeController().flagColor(
                                controller.employees[index].dateOfJoining!),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                            onTap: (() {
                              controller.deleteEmployees(
                                  controller.employees[index].id!, index);
                            }),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      )),
                ),
              );
            }));
      }),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Get.to(() => const AddEmployee());
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }
}
