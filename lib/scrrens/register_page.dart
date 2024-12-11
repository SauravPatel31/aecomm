import 'dart:convert';

import 'package:aecomm/scrrens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget{

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();

  TextEditingController mobController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();

  registerUser({required String name,required String mob ,required String email,required String pass})async{
    var url ="https://www.marketcraft.in/ecommerce-api/user/registration";
    var resp = await http.post(Uri.parse(url),body: {
      "name":name,
      "mobile_number":mob,
      "email":email,
      "password":pass
    });
    if(resp.statusCode==200){
      var data = jsonDecode(resp.body);
      if(data['status']==true){
        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
      }
      print(data);

      print("Register Success");
    }else{
      print("Register Faild");
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: "Enter The Name"
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: mobController,
            decoration: InputDecoration(
                hintText: "Enter The Mobile"
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
                hintText: "Enter The mail"
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: passController,
            decoration: InputDecoration(
                hintText: "Enter The Pass"
            ),
          ),
          SizedBox(height: 10,),
          ElevatedButton(onPressed: (){
            if(nameController.text.isNotEmpty&&mobController.text.isNotEmpty&&emailController.text.isNotEmpty&&passController.text.isNotEmpty){
              registerUser(name: nameController.text.trim(),mob: mobController.text.trim(), email: emailController.text,pass: passController.text);
            }else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("All filed are reqied")));
            }
          }, child: Text("Register"))
        ],
      ),
    );
  }
}