import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'edit_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PlatformFile> _files = [];

  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: [
        'mp4',
        'mp3',
        'mov',
        'avi',
        'wav',
        'ico',
        'jpg',
        'png',
        'svg',
        'pdf'
      ],
    );

    if (result != null) {
      setState(() {
        _files = result.files;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SEO Metadata Editor'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _pickFiles,
            child: Text('Select Files'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _files.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.file_present),
                  title: Text(_files[index].name),
                  subtitle: Text('Size: ${_files[index].size} bytes'),
                  trailing: ElevatedButton(
                    child: Text('Edit'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditScreen(file: _files[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
