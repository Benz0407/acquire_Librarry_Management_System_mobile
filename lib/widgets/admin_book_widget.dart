import 'package:acquire_lms_mobile_app/config/app_router.gr.dart';
import 'package:acquire_lms_mobile_app/provider/book_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminBookWidget extends StatefulWidget {
  final String? id;
  final String? title;
  final String? subtitle;
  final String? thumbnail;
  final String? author;
  final int availableCopies;
  final String userRole;
  final String? bookStatus; // Add this line to include bookStatus

  const AdminBookWidget({
    super.key,
    this.id,
    this.title,
    this.subtitle,
    this.thumbnail,
    this.author,
    this.availableCopies = 0,
    required this.userRole,
    this.bookStatus, // Add this line to include bookStatus
  });

  @override
  State<AdminBookWidget> createState() => _AdminBookWidgetState();
}

class _AdminBookWidgetState extends State<AdminBookWidget> {
  bool _isApproveButtonEnabled = true;
  bool _isDeclineButtonEnabled = true;
  String _approveButtonText = 'Approve';
  String _declineButtonText = 'Decline';

  @override
  void initState() {
    super.initState();
    // Check the initial book status and set button states accordingly
    if (widget.bookStatus == 'Approved') {
      _isApproveButtonEnabled = false;
      _approveButtonText = 'Approved';
      _isDeclineButtonEnabled = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      elevation: 0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            widget.thumbnail ?? "",
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
                    widget.title ?? "-",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.author ?? "Unknown Author",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${widget.availableCopies} Available",
                    style: TextStyle(
                      color: widget.availableCopies > 0 ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  if (widget.userRole == 'Library Admin')
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: _isApproveButtonEnabled
                              ? () {
                                  _updateBookStatus(context, widget.id, "Approved");
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                          child: Text(_approveButtonText),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _isDeclineButtonEnabled
                              ? () {
                                  _deleteBook(context, widget.id);
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          child: Text(_declineButtonText),
                        ),
                      ],
                    )
                  else if (widget.userRole == "Librarian")
                    Row(
                      children: [
                        if (widget.bookStatus != 'Approved' && widget.bookStatus != 'Declined')
                          const Text(
                            'Waiting for Approval',
                            style: TextStyle(color: Colors.orange),
                          )
                        else if (widget.bookStatus == 'Declined')
                          const Text(
                            'Declined',
                            style: TextStyle(color: Colors.red),
                          )
                        else if (widget.bookStatus == 'Approved')
                          const Text(
                            'Approved',
                            style: TextStyle(color: Colors.green),
                          ),
                        const SizedBox(width: 8),
                        if (widget.bookStatus != 'Approved' && widget.bookStatus != 'Declined')
                          ElevatedButton(
                           onPressed: _isDeclineButtonEnabled
                              ? () {
                                  _deleteBook(context, widget.id);
                                }
                              : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white
                            ),
                            child: const Text('Cancel'),
                          ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            // Handle place hold action
                          },
                          child: const Text('Place Hold'),
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          onPressed: () {
                            // Handle add to list action
                          },
                          child: const Text(
                            'Add to List',
                            style: TextStyle(color: Colors.red),
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

  void _updateBookStatus(BuildContext context, String? bookId, String status) async {
    if (bookId != null) {
      final booksProvider = Provider.of<BooksProvider>(context, listen: false);
      await booksProvider.updateBookStatus(bookId, status);
      setState(() {
        _isApproveButtonEnabled = false;
        _approveButtonText = 'Approved';
        _isDeclineButtonEnabled = false;
      });
      // Optionally refresh or navigate
    }
  }

  void _deleteBook(BuildContext context, String? bookId) async {
    if (bookId != null) {
      final booksProvider = Provider.of<BooksProvider>(context, listen: false);
      await booksProvider.deleteBook(bookId);
      context.pushRoute(const CollectionScreen());
    }
  }
}
