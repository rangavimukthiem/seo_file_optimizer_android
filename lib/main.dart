import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:image/image.dart';
import 'package:path/path.dart' as path;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  File? selectedFile;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      if (result.files.isNotEmpty) {
        String fileName = path.basename(result.files.single.name);
        String fileSize = _formatBytes(result.files.single.size!);
        String fileExtension = path.extension(result.files.single.path!);

        print('File picked: $fileName');
        print('File size: $fileSize');
        print('File extension: $fileExtension');
      } else {
        print('No file picked');
      }
    } else {
      setState(() {
        if (result != null) {
          selectedFile = File(result.files.single.path!);
        }
      });
    }
    // -----------------
  }

  String _formatBytes(int bytes) {
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB'];
    int i = 0;
    double fileSize = bytes.toDouble();
    while (fileSize > 1024 && i < suffixes.length - 1) {
      fileSize /= 1024;
      i++;
    }
    return '${fileSize.toStringAsFixed(2)} ${suffixes[i]}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.fill,
                opacity: 1,
              ),
            ),
          ),
          Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Boost Your Files, Amplify Your Reach: Make Metadata Work for You!',
                  style: TextStyle(
                      fontSize: 34,
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontFamily: AutofillHints.addressCity,
                      decorationColor: Colors.cyan),
                ),
              ),
              Container(
                child: selectedFile == null
                    ? SizedBox(
                        child: GestureDetector(
                          onTap: _pickFile,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(50.0),

                              // borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Center(
                              child: Text(
                                'Browse File',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      )
                    : _buildFileDetails(),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildFileDetails() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('File Name: ${selectedFile!.path.split('/').last}'),
          Text('File Size: ${selectedFile!.lengthSync()} bytes'),
          // Display more file details and metadata here
          ElevatedButton(
            onPressed: () {
              print("edit button pressed ");
              // Implement edit functionality
            },
            child: const Text('Edit Metadata'),
          ),
          ElevatedButton(
            onPressed: () {
              // Implement save functionality
              print("save button pressed ");
            },
            child: const Text('Save Metadata'),
          ),
        ],
      ),
    );
  }
}
