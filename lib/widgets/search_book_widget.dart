import 'package:flutter/material.dart';

class SearchBookWidget extends StatelessWidget {
  final String? id;
  final String? title;
  final String? subtitle;
  final List<String>? author;
  final String? description;
  final String? thumbnail;
  final String? bookUrl;
  final int availableCopies;
  final String? edition;
  final String? publisher;
  final String? isbn;
  final String? length;
  final List<String>? subjects;
  final List<String>? categories;
  final VoidCallback? onAddToCatalogPressed;

  const SearchBookWidget({
    super.key,
    this.id,
    this.title,
    this.subtitle,
    this.author,
    this.description,
    this.thumbnail,
    this.bookUrl,
    this.availableCopies = 0,
    this.edition,
    this.publisher,
    this.isbn,
    this.length,
    this.subjects,
    this.categories,
    this.onAddToCatalogPressed,
  });
  


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      elevation: 0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            thumbnail ?? "",
            height: 130,
            width: 100,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    title ?? "-",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    author != null ? author!.join(", ") : "Unknown Author",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "$availableCopies Available",
                    style: TextStyle(
                      color: availableCopies > 0 ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Column(
                    children: [
                      // Your existing book widget content
                      // Add the "Add to Catalog" button here if needed
                      if (onAddToCatalogPressed !=
                          null) // Check if the callback is provided
                        ElevatedButton(
                          onPressed: onAddToCatalogPressed,
                          child: const Text('Add to Catalog'),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
