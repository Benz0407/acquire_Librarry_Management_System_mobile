import 'dart:convert';
import 'dart:typed_data';
import 'package:html/parser.dart' show parse;

class BookModel {
  String? id;
  String? title;
  String? subtitle;
  List<String>? authors;
  String? description;
  String? thumbnail;
  String? bookUrl;
  int availableCopies;
  String? edition;
  String? publisher;
  String? isbn;
  String? length;
  List<String>? subjects;
  List<String>? categories;
  Uint8List? coverBlob; 
  String? bookStatus; 

  BookModel({
    this.id,
    this.title,
    this.subtitle,
    this.authors,
    this.description,
    this.thumbnail,
    this.bookUrl,
    this.availableCopies = 1,
    this.edition,
    this.publisher,
    this.isbn,
    this.length,
    this.subjects,
    this.categories,
    this.coverBlob, 
    this.bookStatus,
  });

  String _stripHtmlTags(String htmlString) {
    final document = parse(htmlString);
    return parse(document.body?.text).documentElement?.text ?? '';
  }

  factory BookModel.fromApi(Map<String, dynamic> data) {
    String getThumbnailSafety(Map<String, dynamic> data) {
      final imageLinks = data['volumeInfo']['imageLinks'];
      if (imageLinks != null && imageLinks['thumbnail'] != null) {
        return imageLinks['thumbnail'];
      } else {
        return "https://yt3.ggpht.com/ytc/AKedOLR0Q2jl80Ke4FS0WrTjciAu_w6WETLlI0HmzPa4jg=s176-c-k-c0x00ffffff-no-rj";
      }
    }

    List<String> getAuthors(Map<String, dynamic> data) {
      final authors = data['volumeInfo']['authors'];
      if (authors != null) {
        return List<String>.from(authors);
      } else {
        return ["Unknown Author"];
      }
    }

    int getAvailableCopies(Map<String, dynamic> data) {
      final availableCopies = data['volumeInfo']['availableCopies'];
      if (availableCopies != null) {
        return availableCopies;
      } else {
        return 1; 
      }
    }

    final bookModel = BookModel(
      id: data['id'],
      title: data['volumeInfo']['title'],
      subtitle: data['volumeInfo']['subtitle'],
      authors: getAuthors(data),
      description: data['volumeInfo']['description'],
      thumbnail: getThumbnailSafety(data).replaceAll("http", "https"),
      bookUrl: data['volumeInfo']['previewLink'],
      availableCopies: getAvailableCopies(data),
      edition: data['volumeInfo']['edition'],
      publisher: data['volumeInfo']['publisher'],
      isbn: data['volumeInfo']['industryIdentifiers'] != null && data['volumeInfo']['industryIdentifiers'].length > 0
          ? data['volumeInfo']['industryIdentifiers'][0]['identifier']
          : null,
      length: data['volumeInfo']['pageCount'] != null ? '${data['volumeInfo']['pageCount']} pages' : null,
      subjects: data['volumeInfo']['categories'] != null
          ? List<String>.from(data['volumeInfo']['categories'])
          : null,
          categories: data['volumeInfo']['categories'] != null
          ? List<String>.from(data['volumeInfo']['categories'])
          : null,
          coverBlob: data['coverBlob'] != null ? base64Decode(data['coverBlob']) : null,
          bookStatus: data['bookStatus']
    );

    // Strip HTML tags from the description
    if (bookModel.description != null) {
      bookModel.description = bookModel._stripHtmlTags(bookModel.description!);
    }

    return bookModel;
  }

factory BookModel.fromJson(Map<String, dynamic> json) {
  return BookModel(
    id: json['id'],
    title: json['title'],
    subtitle: json['subtitle'],
    authors: json['authors'] != null && json['authors'] is List
        ? List<String>.from(json['authors'])
        : [],
    description: json['description'],
    thumbnail: json['thumbnail'],
    bookUrl: json['bookUrl'],
    availableCopies: json['availableCopies'] != null ? int.parse(json['availableCopies'].toString()) : 1,
    edition: json['edition'],
    publisher: json['publisher'],
    isbn: json['isbn'],
    length: json['length'],
    subjects: json['subjects'] != null && json['subjects'] is List
        ? List<String>.from(json['subjects'])
        : [],
    categories: json['categories'] != null && json['categories'] is List
        ? List<String>.from(json['categories'])
        : [], // Ensure 'categories' is always parsed as a List
    coverBlob: json['coverBlob'] != null ? base64Decode(json['coverBlob']) : null,
    bookStatus: json['bookStatus']
  );
}


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'authors': authors,
      'description': description,
      'thumbnail': thumbnail,
      'bookUrl': bookUrl,
      'availableCopies': availableCopies,
      'edition': edition,
      'publisher': publisher,
      'isbn': isbn,
      'length': length,
      'subjects': subjects,
      'categories': categories,
      'coverBlob': coverBlob != null ? base64Encode(coverBlob!) : null,
      'bookStats' : bookStatus
    };
  }

  BookModel copyWith({
    String? title,
    String? subtitle,
    List<String>? authors,
    String? description,
    String? thumbnail,
    String? bookUrl,
    int? availableCopies,
    String? edition,
    String? publisher,
    String? isbn,
    String? length,
    List<String>? subjects,
    List<String>? categories,
    Uint8List? coverBlob,
    String? bookStatus
  }) {
    return BookModel(
      id: id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      authors: authors ?? this.authors,
      description: description ?? this.description,
      thumbnail: thumbnail ?? this.thumbnail,
      bookUrl: bookUrl ?? this.bookUrl,
      availableCopies: availableCopies ?? this.availableCopies,
      edition: edition ?? this.edition,
      publisher: publisher ?? this.publisher,
      isbn: isbn ?? this.isbn,
      length: length ?? this.length,
      subjects: subjects ?? this.subjects,
      categories: categories ?? this.categories,
      coverBlob: coverBlob ?? this.coverBlob, 
      bookStatus: bookStatus ?? this.bookStatus
    );
  }
}
