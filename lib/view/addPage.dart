import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task/widgets/textFeild.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  File? _image;
  final TextEditingController _captionController = TextEditingController();
  final Box postBox = Hive.box('postBox');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: pickImage,
              child: _image != null
                  ? Image.file(_image!, height: 200, fit: BoxFit.cover)
                  : Container(
                      height: 200,
                      color: Colors.grey[300],
                      child: Center(child: Text('Tap to select image')),
                    ),
            ),
            Gap(20),
            textFieldCustom(controller: _captionController, hintText: "Write a caption..."),
            Gap(20),
            ElevatedButton(
              onPressed: savePost,
              child: Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
    // Pick image from gallery
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
    // Save post to Hive
  void savePost() {
    if (_captionController.text.isEmpty && _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please add image or caption')),
      );
      return;
    }

    final post = {
      'id': DateTime.now().toString(),
      'imagePath': _image?.path ?? '',
      'caption': _captionController.text,
      'liked': false,
    };

    postBox.add(post); // add post to Hive
    Navigator.pop(context); // go back to Home Page
  }
}
