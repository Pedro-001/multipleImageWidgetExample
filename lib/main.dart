import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _imageList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            OutlinedButton(
              onPressed: () {
                imageSelect();
              },
              child: Text('Select a Image'),
            ),
            SizedBox(
              height: 10,
            ),
            OutlinedButton(
              onPressed: () {
                multiImageSelect();
              },
              child: Text('Select multiple Images'),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: _imageList.length,
                itemBuilder: (BuildContext context, int index) {
                  print('info:  $_imageList');
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.file(
                          File(_imageList[index].path),
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                            right: -4,
                            top: -4,
                            child: Container(
                              color: Color.fromRGBO(255, 255, 255, 0.7),
                              child: IconButton(
                                onPressed: () {
                                  _imageList.removeAt(index);
                                  setState(() {});
                                },
                                icon: Icon(Icons.delete),
                                color: Colors.red,
                              ),
                            ))
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void imageSelect() async {
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (selectedImage!.path.isNotEmpty) {
      _imageList.add(selectedImage);
    }
    setState(() {});
    print(selectedImage.path.toString());
  }

  void multiImageSelect() async {
    final List<XFile>? multiselectedImage = await _picker.pickMultiImage();
    _imageList = multiselectedImage!;

    setState(() {});
  }
}
