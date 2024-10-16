import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scanner_app/core/colors.dart';
import 'package:scanner_app/core/spaces.dart';
import 'package:scanner_app/data/models/documents.dart';
import 'package:scanner_app/pages/detail_document_page.dart';

class LatestDocuments extends StatefulWidget {
  final List<DocumentModel> documents;
  const LatestDocuments({super.key, required this.documents});

  @override
  State<LatestDocuments> createState() => _LatestDocumentsState();
}

class _LatestDocumentsState extends State<LatestDocuments> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: widget.documents.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 4 / 3),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey[200],
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailDocumentPage(document: widget.documents[index],)));
              },
              child: Column(children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      width: double.infinity,
                      File(widget.documents[index].path!),
                      fit: BoxFit.cover,
                      colorBlendMode: BlendMode.colorBurn,
                      color: AppColors.primary.withOpacity(0.2),
                    ),
                  ),
                ),
                const SpaceHeight(4),
                // Icon(Icons.description,
                // size: 40.0,
                // color: Colors.amber,),
                SizedBox(
                  width: 70,
                  child: Text(
                    widget.documents[index].name!,
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ]),
            ),
          );
        });
  }
}
