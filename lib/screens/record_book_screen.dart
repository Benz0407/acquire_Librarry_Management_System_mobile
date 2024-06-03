import 'dart:io';

import 'package:acquire_lms_mobile_app/config/app_router.gr.dart';
import 'package:acquire_lms_mobile_app/models/book_model.dart';
import 'package:acquire_lms_mobile_app/provider/book_provider.dart';
import 'package:acquire_lms_mobile_app/utils/spaces.dart';
import 'package:acquire_lms_mobile_app/widgets/app_bar_widget.dart';
import 'package:acquire_lms_mobile_app/widgets/build_app_drawer.dart';
import 'package:acquire_lms_mobile_app/widgets/screen_title_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

@RoutePage()
class RecordBookPage extends StatefulWidget {
  const RecordBookPage({super.key});

  @override
  RecordBookPageState createState() => RecordBookPageState();
}

class RecordBookPageState extends State<RecordBookPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _copiesController = TextEditingController();
  final TextEditingController _isbnController = TextEditingController();
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

   void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newBook = BookModel(
        id: const Uuid().v4(),
        title: _titleController.text,
        subtitle: _subtitleController.text,
        authors: _authorController.text.split(',').map((e) => e.trim()).toList(),
        description: _descriptionController.text,
        thumbnail: _image?.path ?? '',
        bookUrl: '', // Add a URL if needed
        availableCopies: int.parse(_copiesController.text),
      );

      Provider.of<BooksProvider>(context, listen: false).addBook(newBook);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Book "${newBook.title}" added successfully!')),
      );

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.red),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
        leading: TextButton(
          onPressed: () {
            context..router.navigate(const CollectionScreen());
          },
          child: const Text(
            'Back',
            style: TextStyle(color: Colors.red),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: const Color(0xFF909090),
            height: 4.0,
            margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 13.0),
          ),
        ),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80,
        title: Center(
          child: Image.asset(
            'assets/Logo.png',
            height: 50,
          ),
        ),
      ),
      endDrawer: const BuildAppDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ScreenHeader(headerText: "Record Book"),
                  ],
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _pickImage,
                  child: _image == null
                      ? Column(
                          children: [
                            Image.asset(
                              'assets/book-placeholder.jpg',
                              height: 100,
                            ),
                            const Text(
                              'Upload Book Cover',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        )
                      : Image.file(
                          _image!,
                          height: 100,
                        ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Book Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the book title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _authorController,
                  decoration: const InputDecoration(labelText: 'Author'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the author';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _subtitleController,
                  decoration:
                      const InputDecoration(labelText: 'Subtitle'),
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Descripton'),
                ),
                TextFormField(
                  controller: _copiesController,
                  decoration: const InputDecoration(labelText: 'Copies'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the number of copies';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _isbnController,
                  decoration: const InputDecoration(labelText: 'ISBN'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a ISBN';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Implement cancel functionality
                      },
                      child: const Text('Cancel'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.grey,
                      ),
                    ),
                   ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Confirm'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
