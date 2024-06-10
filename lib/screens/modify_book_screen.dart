import 'package:acquire_lms_mobile_app/models/book_model.dart';
import 'package:acquire_lms_mobile_app/provider/book_provider.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ModifyBookScreen extends StatefulWidget {
  final String bookId;

  const ModifyBookScreen({super.key, required this.bookId});

  @override
  State<ModifyBookScreen> createState() => _ModifyBookScreenState();
}

class _ModifyBookScreenState extends State<ModifyBookScreen> {
  final _formKey = GlobalKey<FormState>();
  late BookModel _bookModel;
  bool _isLoading = true;
  final BooksProvider _bookProvider = BooksProvider();

  @override
  void initState() {
    super.initState();
    _fetchBookDetails();
  }

  Future<void> _fetchBookDetails() async {
    try {
      final bookDetails = await _bookProvider.fetchBookDetails(widget.bookId);
      setState(() {
        _bookModel = BookModel.fromApi(bookDetails);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load book details: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Modify Book'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Modify Book'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _bookModel.title,
                decoration: const InputDecoration(labelText: 'Title'),
                onSaved: (value) {
                  _bookModel = _bookModel.copyWith(title: value);
                },
              ),
              TextFormField(
                initialValue: _bookModel.subtitle,
                decoration: const InputDecoration(labelText: 'Subtitle'),
                onSaved: (value) {
                  _bookModel = _bookModel.copyWith(subtitle: value);
                },
              ),
              TextFormField(
                initialValue: _bookModel.authors?.join(', '),
                decoration: const InputDecoration(labelText: 'Authors'),
                onSaved: (value) {
                  _bookModel = _bookModel.copyWith(authors: value?.split(', '));
                },
              ),
              TextFormField(
                initialValue: _bookModel.description,
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) {
                  _bookModel = _bookModel.copyWith(description: value);
                },
              ),
              TextFormField(
                initialValue: _bookModel.thumbnail,
                decoration: const InputDecoration(labelText: 'Thumbnail URL'),
                onSaved: (value) {
                  _bookModel = _bookModel.copyWith(thumbnail: value);
                },
              ),
              TextFormField(
                initialValue: _bookModel.bookUrl,
                decoration: const InputDecoration(labelText: 'Book URL'),
                onSaved: (value) {
                  _bookModel = _bookModel.copyWith(bookUrl: value);
                },
              ),
              TextFormField(
                initialValue: _bookModel.availableCopies.toString(),
                decoration: const InputDecoration(labelText: 'Available Copies'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _bookModel =
                      _bookModel.copyWith(availableCopies: int.parse(value!));
                },
              ),
              TextFormField(
                initialValue: _bookModel.edition,
                decoration: const InputDecoration(labelText: 'Edition'),
                onSaved: (value) {
                  _bookModel = _bookModel.copyWith(edition: value);
                },
              ),
              TextFormField(
                initialValue: _bookModel.publisher,
                decoration: const InputDecoration(labelText: 'Publisher'),
                onSaved: (value) {
                  _bookModel = _bookModel.copyWith(publisher: value);
                },
              ),
              TextFormField(
                initialValue: _bookModel.isbn,
                decoration: const InputDecoration(labelText: 'ISBN'),
                onSaved: (value) {
                  _bookModel = _bookModel.copyWith(isbn: value);
                },
              ),
              TextFormField(
                initialValue: _bookModel.length,
                decoration: const InputDecoration(labelText: 'Length'),
                onSaved: (value) {
                  _bookModel = _bookModel.copyWith(length: value);
                },
              ),
              TextFormField(
                initialValue: _bookModel.subjects?.join(', '),
                decoration: const InputDecoration(labelText: 'Subjects'),
                onSaved: (value) {
                  _bookModel =
                      _bookModel.copyWith(subjects: value?.split(', '));
                },
              ),
              DropdownButtonFormField<String>(
                value: _bookModel.categories?.isNotEmpty == true ? _bookModel.categories![0] : null,
                decoration: const InputDecoration(labelText: 'Category'),
                items: (_bookModel.categories ?? []).map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _bookModel.categories = [value];
                    });
                  }
                },
                onSaved: (value) {
                  if (value != null) {
                    _bookModel = _bookModel.copyWith(categories: [value]);
                  }
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _saveModifiedBookDetails(context);
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveModifiedBookDetails(BuildContext context) async {
  final booksProvider = Provider.of<BooksProvider>(context, listen: false);

  try {
    await booksProvider.updateBook(_bookModel);
    print('Modified Book Details: ${_bookModel.toJson()}');
    // Add any additional logic here, e.g., showing a success message
    Navigator.pop(context); // Navigate back or close the dialog
  } catch (e) {
    print('Error saving modified book details: $e');
    // Handle error, e.g., showing an error message
  }
}


}
