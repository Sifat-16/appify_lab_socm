import 'package:flutter/material.dart';

Future<void> showDeleteConfirmationDialog(BuildContext context, VoidCallback delete) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Delete Item'),
        content: Text('Are you sure you want to delete this item?'),
        actions: <Widget>[
          TextButton(
            onPressed: delete,
            child: Text('Delete'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Cancel'),
          ),
        ],
      );
    },
  );
}