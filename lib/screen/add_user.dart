
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import '../logic/user_controller.dart';
import 'package:intl/intl.dart';

import '../utils/widget.dart';

class AddUser extends StatefulWidget {
  @override
  State<AddUser> createState() => _AddUserinState();
}

class _AddUserinState extends State<AddUser> {
  _AddUserinState createState() => _AddUserinState();

  final controller = Get.put(UserController());

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Container(
        margin: EdgeInsets.only(top: 20, left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Fullname"),
              SizedBox(height: 5,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: controller.decorationSetting,
                    border: Border.all(width: 1.0, color: Colors.black)),
                child: Container(
                  padding: const EdgeInsets.only(left: 5, right: 10),
                  child:  TextField(
                        keyboardType : TextInputType.text,
                        controller: controller.fullname.value,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.supervised_user_circle),
                        ),
                        style: TextStyle(
                            fontSize: 14.0, height: 2.0, color: Colors.black),
                        onChanged : (value){
                          setState(() {
                            var lengthVal = value.length;
                            var thereNumber = RegExp(r'^[a-zA-Z" "]+$').hasMatch(value.toLowerCase());
                            print(thereNumber);
                            if(lengthVal < 3 || !thereNumber){
                              controller.textValidasi1.value = "Minimal 3 karakter dan harus text";
                            }else{
                              controller.textValidasi1.value = "";
                            }
                          });

                        }
                      ),
                  ),
                  ),

              SizedBox(height: 5,),
              Obx(() =>  Text(controller.textValidasi1.value, style: TextStyle(color: Colors.red),)),
              SizedBox(height: 10,),
              Text("Email"),
              SizedBox(height: 5,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: controller.decorationSetting,
                    border: Border.all(width: 1.0, color: Colors.black)),
                child: Container(
                  padding: const EdgeInsets.only(left: 5, right: 10),
                  child: TextField(
                    controller: controller.email.value,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.mail_outline),
                    ),
                    style: TextStyle(
                        fontSize: 14.0, height: 2.0, color: Colors.black),
                    onChanged: (value) {
                      var hasil = controller.validateEmail(value);
                      setState(() {
                        if(!hasil){
                          controller.textValidasi2.value = "Enter a valid email address";
                        }else{
                          controller.textValidasi2.value = "";
                        }
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Obx(() =>  Text(controller.textValidasi2.value, style: TextStyle(color: Colors.red),)),
              SizedBox(height: 10,),
              Text("Password"),
              SizedBox(height: 5,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: controller.decorationSetting,
                    border: Border.all(width: 1.0, color: Colors.black)),
                child: Container(
                  padding: const EdgeInsets.only(left: 5, right: 10),
                  child: TextField(
                    obscureText: !this.controller.showpassword.value,
                    controller: controller.password.value,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: const Icon(Icons.security),
                        // ignore: unnecessary_this
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: this.controller.showpassword.value
                                ? Colors.blue
                                : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() => this.controller.showpassword.value =
                            !this.controller.showpassword.value);
                          },
                        )),
                    style: TextStyle(
                        fontSize: 14.0, height: 2.0, color: Colors.black),
                    onChanged: (value){
                      var checking1 = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value);
                      var lengthVal = value.length;
                      if(!checking1 || lengthVal < 6){
                        controller.textValidasi3.value = "Password harus huruf, angka dan min 6 karakter";
                      }else{
                        controller.textValidasi3.value = "";
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Obx(() =>  Text(controller.textValidasi3.value, style: TextStyle(color: Colors.red),)),
              SizedBox(height: 10,),
              Text("Confirm Password"),
              SizedBox(height: 5,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: controller.decorationSetting,
                    border: Border.all(width: 1.0, color: Colors.black)),
                child: Container(
                  padding: const EdgeInsets.only(left: 5, right: 10),
                  child: TextField(
                    obscureText: !this.controller.showpassword2.value,
                    controller: controller.confirmPassword.value,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: const Icon(Icons.security),
                        // ignore: unnecessary_this
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: this.controller.showpassword2.value
                                ? Colors.blue
                                : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() => this.controller.showpassword2.value =
                            !this.controller.showpassword2.value);
                          },
                        )),
                    style: TextStyle(
                        fontSize: 14.0, height: 2.0, color: Colors.black),
                    onChanged: (value){
                      bool matchValue = value == controller.password.value.text;
                      if(!matchValue){
                        controller.textValidasi4.value = "Password tidak sama";
                      }else{
                        controller.textValidasi4.value = "";
                      }
                    },
                  ),
                )
              ),
              SizedBox(height: 5,),
              Obx(() =>  Text(controller.textValidasi4.value, style: TextStyle(color: Colors.red),)),
              SizedBox(height: 10,),
              Text("Gender"),
              SizedBox(height: 5,),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      border: Border.all(width: 1.0, color: Colors.black)),
                  child: InkWell(
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Container(
                              color: Color.fromARGB(255, 250, 249, 249),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        controller.valgender.value.text = "1";
                                        controller.gender.value.text = "Laki-Laki";
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      child: Text("Laki-Laki"),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        controller.valgender.value.text = "2";
                                        controller.gender.value.text = "Perempuan";
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      child: Text("Perempuan"),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 5, right: 10, top: 8),
                      child: Obx(() => Text(controller.gender.value.text, style: TextStyle(fontWeight: FontWeight.bold),))
                    ),
                  )
              ),
              SizedBox(height: 20,),
              Text("Date of Birth"),
              SizedBox(height: 5,),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: controller.decorationSetting,
                      border: Border.all(width: 1.0, color: Colors.black)),
                  child: Container(
                    padding: const EdgeInsets.only(left: 5, right: 10, bottom: 5),
                    child: DateTimeField(
                      format: DateFormat('dd-MM-yyyy'),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: const Icon(Icons.calendar_month),
                      ),
                      controller: controller.date_of_birth.value,
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                      },
                    ),
                  )
              ),
              SizedBox(height: 15,),
              Obx(() => Row(
                  children: [
                    Checkbox(
                      value: this.controller.validasiAgree.value,
                      onChanged: (value) {
                        setState(() => this.controller.validasiAgree.value =
                        !this.controller.validasiAgree.value);
                      },
                    ),
                    Text("Data di atas benar apa adanya")
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  if(controller.validasiAgree.value == true){
                    controller.validasiRegis(context);
                  }else{
                    Utils.toastSukses(context, "Silahkan checklist data di atas");
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 15, bottom: 15),
                  decoration: BoxDecoration(
                    color: controller.validasiAgree.value == false ? Colors.grey : Colors.blue,
                    borderRadius: controller.decorationSetting,
                  ),
                  child: Center(
                    child: Container(padding: EdgeInsets.all(10), child: Text("Submit")),
                  ),
                )
              )

            ],
          ),
        ),
      )


    ));
  }




}