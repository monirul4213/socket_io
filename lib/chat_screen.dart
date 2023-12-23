import 'dart:io';

import 'package:chatmat/image_show.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';


class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
   /// Get from gallery

File? image_route;

ImagePicker _imagePicker = ImagePicker();

Future<void> image_picker() async {
final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
  setState(() {
    image_route = File(image!.path);
    print(image_route);
  });
}
  late IO.Socket socket;
  TextEditingController messageController = TextEditingController();
  List<String> messages = [];

  @override
  void initState() {
    super.initState();
    connectToServer();
  }
  void connectToServer() {
    socket = IO.io("http://192.168.0.108:8000", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
    socket.on('message', (data) {
      setState(() {
        messages.add(data);
      });
    });
  }
  void sendMessage() {
    String message = messageController.text.trim();
    if (message.isNotEmpty) {
      socket.emit('message', message);
      messageController.clear();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Socket.IO Chat'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Colors.blueAccent,
                      child: ListTile(
                        title: Text(messages[index],style: TextStyle(fontSize: 25),),
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'Type your message here...',
                      ),
                    ),
                  ),
                   IconButton(
                    icon: Icon(Icons.camera),
                    onPressed: (){
                    image_picker();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>imae_show(file: image_route!)));
                    }
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: sendMessage,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}