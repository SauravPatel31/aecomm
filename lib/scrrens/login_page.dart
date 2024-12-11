import 'dart:convert';
import 'dart:io';

import 'package:aecomm/scrrens/home_page.dart';
import 'package:aecomm/scrrens/register_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  loginUser(String email,String pass)async{
    try{
      dynamic resp= await http.post(Uri.parse("https://www.marketcraft.in/ecommerce-api/user/login"),body: {
        "email":email,
        "password":pass
      });
      if(resp.statusCode==200){
        var logiData= jsonDecode(resp.body.toString());
        print(logiData);
        if(resp['status']==true){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Success"),backgroundColor: Colors.green,));
        }else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(resp['message']),backgroundColor: Colors.red,));
        }
      }
    }catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()),backgroundColor: Colors.red,));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller:emailController ,
            decoration: InputDecoration(
              hintText: "Enter The Mail"
            ),
          ),
          TextField(
            controller: passController,
            decoration: InputDecoration(
              hintText: "Enter The Password"
            ),
          ),
          ElevatedButton(onPressed: (){
            if(emailController.text.isNotEmpty&&passController.text.isNotEmpty){
              loginUser(emailController.text, passController.text);
            }else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("All filed are reqied")));
            }
          }, child: Text("Login")),
          TextButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterPage(),));
          }, child: Text("New User! Register Now "))
        ],
      ),
    );
  }
}
