import 'package:flutter/material.dart';
import 'package:scanner_app/data/datasources/document_local_datasource.dart';
import 'package:scanner_app/data/models/documents.dart';
import 'package:scanner_app/pages/latest_documents.dart';

class DoucumentCategoryPage extends StatefulWidget {
  final String categoryTitle;
  const DoucumentCategoryPage({super.key, required this.categoryTitle});

  @override
  State<DoucumentCategoryPage> createState() => _DoucumentCategoryPageState();
}

class _DoucumentCategoryPageState extends State<DoucumentCategoryPage> {
  List<DocumentModel> documents = [];

  
  loadData() async {
    documents = await DocumentLocalDatasource.instance
        .getDocumentByCategory(widget.categoryTitle);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('document ${widget.categoryTitle}'),),
      body: Column(
        children: [
          Expanded(child: LatestDocuments(documents:documents,))
        ],
      ),
      );
  }
}