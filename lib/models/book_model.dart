class BookModel {
  String? id;
  String? title;
  String? subtitle;
  List<String>? authors;
  String? description;
  String? thumbnail;
  String? bookUrl;
  int  availableCopies;

  BookModel({
    this.id,
    this.title,
    this.subtitle,
    this.authors,
    this.description,
    this.thumbnail,
    this.bookUrl,
    this.availableCopies = 1,
  });

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
      // Assuming the available copies information is available in the API response
      // Adjust the path according to your API response structure
      final availableCopies = data['volumeInfo']['availableCopies'];
      if (availableCopies != null) {
        return availableCopies;
      } else {
        return 1; // Default to 0 if not available
      }
    }

    return BookModel(
      id: data['id'],
      title: data['volumeInfo']['title'],
      description: data['volumeInfo']['description'],
      subtitle: data['volumeInfo']['subtitle'],
      authors: getAuthors(data),
      thumbnail: getThumbnailSafety(data).replaceAll("http", "https"),
      bookUrl: data['volumeInfo']['previewLink'],
      availableCopies: getAvailableCopies(data),
    );
  }

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      authors: List<String>.from(json['authors']),
      description: json['description'],
      thumbnail: json['thumbnail'],
      bookUrl: json['bookUrl'],
      availableCopies: int.parse(json['availableCopies']),
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
    };
  }


}
