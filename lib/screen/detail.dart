
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maimaid_crud/screen/add_user.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import '../logic/user_controller.dart';


class DetailUser extends StatefulWidget {
  const DetailUser({Key? key}) : super(key: key);
  @override
  State<DetailUser> createState() => _DetailUserinState();
}

class _DetailUserinState extends State<DetailUser> {
  _DetailUserinState createState() => _DetailUserinState();

  final controller = Get.put(UserController());

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Obx(() => SafeArea(child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.grey.shade50,
        body:  SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30,),
                Center(
                  child: Text("Detail User", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      flex: 30,
                      child: Container(
                        child: Text("Fullname"),
                      ),
                    ),
                    Expanded(flex: 70, child: Text(controller.userDetail[0]['fullname'] ?? "Kosong"))
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      flex: 30,
                      child: Container(
                        child: Text("Email"),
                      ),
                    ),
                    Expanded(flex: 70, child: Text(controller.userDetail[0]['email'] ?? "Kosong"))
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      flex: 30,
                      child: Container(
                        child: Text("Gender"),
                      ),
                    ),
                    Expanded(flex: 70, child: Text(controller.userDetail[0]['gender'] == 1 ? "Laki-Laki" : controller.userDetail[0]['gender'] == 2? "Perempuan" : "kosong"))
                  ],
                ),
              ],
            ),
          ),
        )
    ),
    ),
    );
  }




}