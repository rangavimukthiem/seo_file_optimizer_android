import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../models/metadata_model.dart';
import '../utils/file_utils.dart';

class EditScreen extends StatefulWidget {
  final PlatformFile file;

  EditScreen({required this.file});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late MetadataModel _metadata;

  @override
  void initState() {
    super.initState();
    _metadata = FileUtils.extractMetadata(widget.file);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Metadata - ${widget.file.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField('Title', _metadata.title),
            _buildTextField('Description', _metadata.description),
            _buildTextField('Keywords', _metadata.keywords.join(', ')),
            _buildTextField('Author', _metadata.author),
            if (_metadata.altText != null)
              _buildTextField('Alt Text', _metadata.altText!),
            ElevatedButton(
              onPressed: () {
                FileUtils.saveMetadata(widget.file, _metadata);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String initialValue) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      initialValue: initialValue,
      onChanged: (value) {
        setState(() {
          switch (label) {
            case 'Title':
              _metadata.title = value;
              break;
            case 'Description':
              _metadata.description = value;
              break;
            case 'Keywords':
              _metadata.keywords =
                  value.split(',').map((e) => e.trim()).toList();
              break;
            case 'Author':
              _metadata.author = value;
              break;
            case 'Alt Text':
              _metadata.altText = value;
              break;
          }
        });
      },
    );
  }
}
