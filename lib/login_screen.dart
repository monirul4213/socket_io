import 'dart:convert';
import 'dart:math';

import 'package:chatmat/chat_screen.dart';
import 'package:chatmat/login_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class login_screen extends StatefulWidget {
  const login_screen({super.key});

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {

TextEditingController emailController = TextEditingController();
TextEditingController passController = TextEditingController();
TextEditingController uidController = TextEditingController();
TextEditingController userNameController = TextEditingController();
 void registration() async{
    
      var regBody = {
         'userName':userNameController.text,
          'email':emailController.text,
           'password': passController.text,
           'uid': uidController.text,
      };
      var response = await http.post(Uri.parse('http://192.168.0.108:8000/api/v1/user/register'),
      headers: {"Content-Type":"application/json"},
      body: jsonEncode(regBody)
      );
      var jsonResponse = jsonDecode(response.body);
      

      Navigator.push(context, MaterialPageRoute(builder: (context)=>login_page()));
      
   
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
                     TextFormField(
                      controller: uidController,
                      decoration: InputDecoration(
                       
                        hintText: 'uid',
                      ),
                    ),

                     TextFormField(
                      controller: userNameController,
                      decoration: InputDecoration(
                       
                        hintText: 'userName',
                      ),
                    ),
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
                        registration();
                      },
                      child: Text('Registration'),
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