import 'package:flutter/material.dart';

class BookWidget extends StatelessWidget {
  // final String? _title, _subtitle, _thumbnail;
  final String? title;
  final String? subtitle;
  final String? thumbnail;
  final String? author;
  final int availableCopies;

    const BookWidget({super.key, 
    this.title,
    this.subtitle,
    this.thumbnail,
    this.author,
    this.availableCopies = 0,
  });
  // BookWidget(this._title, this._subtitle, this._thumbnail);

  // @override
  // Widget build(BuildContext context) {
  //   return Card(
  //     margin: EdgeInsets.all(16),
  //     elevation: 0,
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Image.network(
  //           _thumbnail ?? "",
  //           height: 100,
  //           width: 100,
  //           fit: BoxFit.cover,
  //         ),
  //         Expanded (
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Padding(
  //                 padding: EdgeInsets.only(left: 16, right: 16, top: 16),
  //                 child: Text(
  //                   _title ?? "-",
  //                   maxLines: 1,
  //                   overflow: TextOverflow.ellipsis,
  //                   style: TextStyle(fontWeight: FontWeight.bold),
  //                 ),
  //               ),
  //               Padding(
  //                 padding:
  //                     EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
  //                 child: Text(_subtitle ?? "-",
  //                     maxLines: 2, overflow: TextOverflow.ellipsis),
  //               ),
  //             ],
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

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
                    author ?? "Unknown Author",
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
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          // Handle place hold action
                        },
                        child: const Text('Place Hold'),
                      ),
                      const SizedBox(width: 2),
                      TextButton(
                        onPressed: () {
                          // Handle add to list action
                        },
                        child: const Text('Add to List', 
                         style: TextStyle(color: Colors.red)
                        ),
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
