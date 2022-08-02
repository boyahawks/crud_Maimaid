
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maimaid_crud/screen/add_user.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import '../logic/user_controller.dart';


class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);
  @override
  State<User> createState() => _UserinState();
}

class _UserinState extends State<User> {
  _UserinState createState() => _UserinState();

  final controller = Get.put(UserController());

  @override
  void initState() {
    controller.getUser();
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Obx(() => SafeArea(child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.grey.shade50,
        body:  controller.enabled.value == true ? Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  color: Colors.orange,
                ),
              ))
              : Container(
                margin: EdgeInsets.only(top: 10, left: 16, right: 16),
                child: ListView.builder(itemCount: controller.user.value.length, scrollDirection: Axis.vertical ,itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 70,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(controller.user.value[index]['fullname'] ?? "Kosong"),
                                  SizedBox(height: 5,),
                                  Text(controller.user.value[index]['email'] ?? "Kosong"),
                                  SizedBox(height: 5,),
                                  Text(controller.user.value[index]['gender'] == 1 ? "Laki-Laki" : controller.user.value[index]['gender'] == 2 ? "Perempuan" : "Tidak terdaftar"),
                                  SizedBox(height: 5,),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 30,
                              child: Row(
                                children: [
                                  IconButton(onPressed: () {
                                    controller.editUserScreen(controller.user.value[index]);

                                  }, icon: Icon(Icons.edit, size: 20,)),
                                  IconButton(onPressed: () {
                                    var id = controller.user.value[index]['id'];
                                    controller.prosesDetailUser(id);
                                  }, icon: Icon(Icons.remove_red_eye, size: 20,))
                                ],
                              ),
                            )
                          ],
                        ),
                        Divider(height: 5, color: Colors.black,),
                        SizedBox(height: 20,)
                      ],
                    );
                }),
              ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff03dac6),
          foregroundColor: Colors.black,
          onPressed: () {
            Get.to(AddUser());
          },
          child: Icon(Icons.add),
        )
      ),
      ),
    );
  }




}