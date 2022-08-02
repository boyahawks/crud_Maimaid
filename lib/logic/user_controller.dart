import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:maimaid_crud/screen/user.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../screen/add_user.dart';
import '../screen/detail.dart';
import '../utils/api.dart';
import '../utils/widget.dart';

class UserController extends GetxController {

  var fullname = TextEditingController().obs;
  var email = TextEditingController().obs;
  var password = TextEditingController().obs;
  var confirmPassword = TextEditingController().obs;
  var gender = TextEditingController().obs;
  var valgender = TextEditingController().obs;
  var date_of_birth = TextEditingController().obs;
  var textValidasi1 = "".obs;
  var textValidasi2 = "".obs;
  var textValidasi3 = "".obs;
  var textValidasi4 = "".obs;
  var user = [].obs;
  var userDetail = [].obs;
  var enabled = RxBool(false).obs;
  var idUserEdit = 0.obs;
  var showpassword = false.obs;
  var showpassword2 = false.obs;
  var validasiAgree = false.obs;
  var statusEditData = false.obs;
  var decorationSetting = BorderRadius.only(
      topLeft: Radius.circular(15),
      topRight: Radius.circular(15),
      bottomLeft: Radius.circular(15),
      bottomRight: Radius.circular(15));



  getUser() async {
    try {
      user.value.clear();
      enabled.value = true.obs;
      var formData =
      dio.FormData.fromMap(
          {
            "page": 10,
            "offset" : 0
          },
      );
      var response = await dio.Dio().post(Api.readUser, data: formData,);
      var status = response.data['status'];
      var data = response.data['data'];

      user.value = data['rows'];
      enabled.value = false.obs;
      print(user.value);

    } on Exception catch (e) {
      print(e);
    }
  }

  bool validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value))
      return false;
    else
      return true;
  }

  editUserScreen(value){
    print(value);
    idUserEdit.value = value['id'];
    fullname.value.text = value['fullname'] ?? "";
    email.value.text = value['email'] ?? "";
    valgender.value.text = "${value['gender']}" ?? "";
    gender.value.text = value['gender'] == 1 ? "Laki-Laki" : value['gender'] == 2 ? "Perempuan" : "";
    statusEditData.value = true;
    Get.to(AddUser());
  }

  prosesDetailUser(id) {
    userDetail.value.clear();
    user.forEach((element) {
      if(element['id'] == id){
        userDetail.add(element);
      }
    });
    Get.to(DetailUser());
  }

  validasiRegis(context) {
    if(
      fullname.value.text != "" ||
      email.value.text != "" ||
      password.value.text != "" ||
      confirmPassword.value.text != "" ||
      valgender.value.text != "" ||
      date_of_birth.value.text != "" ||
      textValidasi1.value != "" ||
      textValidasi2.value != "" ||
      textValidasi3.value != "" ||
      textValidasi4.value != ""
    ){
      if(statusEditData.value == true){
        simpanDataUser(context, true);
      }else{
        simpanDataUser(context, false);
      }

    }else{
      Utils.toastSukses(context, "Harap Lengkapi Data di atas dengan benar");
    }
  }

  simpanDataUser(context, status) async{
    try {
      Utils.showLoadingIndicator(context);
      var convertPassword = md5.convert(utf8.encode(password.value.text)).toString();
      if(!status){
        var formData =
            {
              "fullname": fullname.value.text,
              "email": email.value.text,
              "password": convertPassword,
              "gender": int.parse(valgender.value.text),
              "dob": "",
            };
        var response = await dio.Dio().post(Api.insertUser,
            data: formData, options: Options(contentType: Headers.formUrlEncodedContentType));
        var data = response.data['status'];

        if(data['code'] == 200){
          Utils.toastSukses(context, "Data berhasil di tambah");
          Navigator.pop(context);
          Navigator.pop(context);
          getUser();
        }
      }else{
        var formData =
        {
          "id": idUserEdit.value,
          "fullname": fullname.value.text,
          "email": email.value.text,
          "password": convertPassword,
          "gender": int.parse(valgender.value.text),
          "dob": "",
        };
        var response = await dio.Dio().post(Api.updateUser,
            data: formData, options: Options(contentType: Headers.formUrlEncodedContentType));
        var data = response.data['status'];

        if(data['code'] == 200){
          Utils.toastSukses(context, "Data berhasil di tambah");
          Navigator.pop(context);
          Navigator.pop(context);
          getUser();
        }
      }


    }on Exception catch (e) {
      Utils.toastSukses(context, e);
    }
  }



}