import 'package:flutter/material.dart';
import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';
import 'package:scanner_app/core/colors.dart';
import 'package:scanner_app/core/spaces.dart';
import 'package:scanner_app/core/title_content.dart';
import 'package:scanner_app/data/datasources/document_local_datasource.dart';
import 'package:scanner_app/data/models/documents.dart';
import 'package:scanner_app/pages/latest_documents.dart';
import 'package:scanner_app/pages/menu_categories.dart';
import 'package:scanner_app/pages/save_document_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DocumentModel> documents = [];

  String? pathImage;
  loadData()async{
    documents = await DocumentLocalDatasource.instance.getAllDocuments();
    setState(() {
      
    });
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
      appBar: AppBar(
        title: const Text('Scanner Kartu'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "scan kartu dan dokumen",
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
                const SpaceHeight(8),
                ElevatedButton(
                    onPressed: () 
                       async{
                          DocumentScannerOptions documentOptions =
                          DocumentScannerOptions(
                        documentFormat: DocumentFormat.jpeg,
                        mode: ScannerMode.filter,
                        pageLimit: 1,
                        isGalleryImport: true,
                      );

                      final documentScanner =
                          DocumentScanner(options: documentOptions);
                      DocumentScanningResult result =
                          await documentScanner.scanDocument();
                      final pdf = result.pdf;
                      final images = result.images;


                      // log('PDF: $pdf');
                      // log('Images: $images');
                      pathImage = images[0];
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> SaveDocumentPage(pathImage: pathImage!,)));
                      },
                    child: Text("Scan Dokumen"))
              ],
            ),
          ),
          const SpaceHeight(16),
          Padding(padding: EdgeInsets.symmetric(horizontal: 16),
          child: TitleContent(title: "Category", onSeeAllTap: (){}),

          ),const SpaceHeight(12),
          const MenuCategories(),
          const SpaceHeight(16),Padding(padding: EdgeInsets.symmetric(horizontal: 16),
          child: TitleContent(title: "Lates Document", onSeeAllTap: (){}),

          ),
          Expanded(child: LatestDocuments(documents: documents,)),
        ],
      ),
    );
  }
}
