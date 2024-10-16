import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scanner_app/core/colors.dart';
import 'package:scanner_app/core/spaces.dart';
import 'package:scanner_app/data/models/documents.dart';

class DetailDocumentPage extends StatefulWidget {
  final DocumentModel document;
  const DetailDocumentPage({super.key, required this.document});

  @override
  State<DetailDocumentPage> createState() => _DetailDocumentPageState();
}

class _DetailDocumentPageState extends State<DetailDocumentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Document'),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Text(
              widget.document.name!,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.center,
            ), const SpaceHeight(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.document.category!,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: AppColors.primary,
                ),
              ),
              Text(
                widget.document.createdAt!,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: AppColors.primary,
                ),
              ),
               IconButton(
                onPressed: () async {
                  // Request storage permission
                  final status = await Permission.storage.request();
                  if (status.isGranted) {
                    // Download the file
                    await downloadFile(widget.document.path!);
                  } else {
                    // Handle permission denied case (optional)
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Storage permission is required to download files.'),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.download),
              )
            ],
          ),
            const SpaceHeight(12),
            ClipRRect(
              child: Image.file(
                  width: double.infinity,
                  fit: BoxFit.contain,
                  color: AppColors.primary.withOpacity(0.2),
                  colorBlendMode: BlendMode.colorBurn,
                  File(widget.document.path!)),
            )
          ],
        ));
  }
}
