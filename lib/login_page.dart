import 'dart:convert';
import 'dart:math';

import 'package:chatmat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class login_page extends StatefulWidget {
  const login_page({super.key});

  @override
  State<login_page> createState() => _login_screenState();
}

class _login_screenState extends State<login_page> {

TextEditingController emailController = TextEditingController();
TextEditingController passController = TextEditingController();




void loginUser() async{
 
      var reqBody = {
        "email":emailController.text,
        "password":passController.text
      };
      var response = await http.post(Uri.parse('http://192.168.0.108:8000/api/v1/user/login'),
          headers: {"Content-Type":"application/json"},
          body: jsonEncode(reqBody)
      );
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      
         
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen()));
      
  
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Add your logo, heading, or background image here

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    

                   
                    // Email input field
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                       
                        hintText: 'Email',
                      ),
                    ),
                    SizedBox(height: 20.0),
                    // Password input field
                    TextFormField(
                      controller: passController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                    ),
                    SizedBox(height: 20.0),
                    // Login button
                    ElevatedButton(
                      onPressed: () {
                        loginUser();
                      },
                      child: Text('Login'),
                    ),
                    // Additional features like "Forgot password?" or "Sign up"
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}