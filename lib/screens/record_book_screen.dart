import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:acquire_lms_mobile_app/config/app_router.gr.dart';
import 'package:acquire_lms_mobile_app/models/book_model.dart';
import 'package:acquire_lms_mobile_app/provider/book_provider.dart';
import 'package:acquire_lms_mobile_app/widgets/build_app_drawer.dart';
import 'package:acquire_lms_mobile_app/widgets/screen_title_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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
  final TextEditingController _editionController = TextEditingController();
  final TextEditingController _publisherController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _subjectsController = TextEditingController();
  final TextEditingController _categoriesController = TextEditingController();

  Uint8List? _imageBytes;

  void _pickImage() async {
    final html.FileUploadInputElement input = html.FileUploadInputElement();
    input.accept = 'image/*';
    input.click();

    input.onChange.listen((event) {
      final html.File file = input.files!.first;
      final reader = html.FileReader();
      reader.readAsArrayBuffer(file); // Read file as array buffer

      reader.onLoadEnd.listen((event) {
        final arrayBuffer = reader.result as Uint8List?;
        if (arrayBuffer != null) {
          setState(() {
            _imageBytes = arrayBuffer; // Update _imageBytes state
          });
        }
      });
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newBook = BookModel(
        id: const Uuid().v4(),
        title: _titleController.text,
        subtitle: _subtitleController.text,
        authors:
            _authorController.text.split(',').map((e) => e.trim()).toList(),
        description: _descriptionController.text,
        thumbnail: '', // This can be set later if needed
        bookUrl: '',
        availableCopies: int.parse(_copiesController.text),
        edition: _editionController.text,
        publisher: _publisherController.text,
        isbn: _isbnController.text,
        length: _lengthController.text,
        subjects:
            _subjectsController.text.split(',').map((e) => e.trim()).toList(),
        categories:
            _categoriesController.text.split(',').map((e) => e.trim()).toList(),
        coverBlob: _imageBytes, // Use Uint8List directly
      );

      Provider.of<BooksProvider>(context, listen: false).addBook(newBook);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Book "${newBook.title}" added successfully!')),
      );

      context.replaceRoute(const CollectionScreen());
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
            context.router.navigate(const CollectionScreen());
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
                  child: _imageBytes == null
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
                      : Image.memory(
                          _imageBytes!,
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
                  decoration: const InputDecoration(labelText: 'Subtitle'),
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
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
                ),
                TextFormField(
                  controller: _editionController,
                  decoration: const InputDecoration(labelText: 'Edition'),
                ),
                TextFormField(
                  controller: _publisherController,
                  decoration: const InputDecoration(labelText: 'Publisher'),
                ),
                TextFormField(
                  controller: _lengthController,
                  decoration: const InputDecoration(labelText: 'Length'),
                ),
                TextFormField(
                  controller: _subjectsController,
                  decoration: const InputDecoration(labelText: 'Subjects'),
                ),
                TextFormField(
                  controller: _categoriesController,
                  decoration: const InputDecoration(labelText: 'Categories'),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width * .4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red),
                        color: Colors.white,
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontFamily: 'League Spartan',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width * .4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.red),
                      child: TextButton(
                        onPressed: _submitForm,
                        child: const Text(
                          'Confirm',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'League Spartan',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
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
