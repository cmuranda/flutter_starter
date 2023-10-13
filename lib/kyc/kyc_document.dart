import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../products/product_home_page.dart';

class KYCDocument extends StatefulWidget {
  const KYCDocument({super.key});

  @override
  State<KYCDocument> createState() => _KYCDocumentState();
}

class _KYCDocumentState extends State<KYCDocument> {
  List<PlatformFile> uploadedDocuments = [];
  var loading = false;

  updateFile(PlatformFile document) {
    setState(() {
      uploadedDocuments.add(document);
    });
  }

  showLoading() {
    setState(() {
      loading = !loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: false,
        title: Text(uploadedDocuments.isEmpty
            ? "Documents upload"
            : "Document Preview"),
      ),
      body: uploadedDocuments.isEmpty
          ? getUploadDocumentView()
          : Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PDFView(
                    filePath: uploadedDocuments.first.path,
                  ),
                  if (loading)
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(100),
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
      floatingActionButton: uploadedDocuments.isEmpty
          ? null
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                  onPressed: () {
                    showLoading();
                    Future.delayed(
                        const Duration(milliseconds: 1500),
                        () => {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ProductsHomePage()))
                            });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    minimumSize: const Size(250, 50),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Padding getUploadDocumentView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Upload Tax Document",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  fontFamily: 'Urbanist'),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 9.0),
            child: Text(
              "Regulations require you to tax clearance documents. Don't worry, your data will stay safe and private",
              style: TextStyle(fontSize: 18, fontFamily: 'Urbanist'),
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              pickFile();
            },
            child: SizedBox(
              height: 300,
              child: Card(
                borderOnForeground: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                    side: BorderSide(width: 4, color: Colors.orange.shade600)),
                child: const Center(
                    child: SizedBox(
                        height: 65,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.file_download,
                              size: 30,
                              color: Colors.grey,
                            ),
                            Text(
                              "Select file",
                              style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                  fontSize: 16),
                            ),
                          ],
                        ))),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: Divider(
            color: Colors.grey.shade200,
            height: 40,
          )),
        ],
      ),
    );
  }

  void pickFile() async {
    final FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'doc']);
    if (result != null) {
      var file = result.files.first;
      updateFile(file);
    }
  }
}
