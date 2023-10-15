import 'dart:io';

import 'package:fin_app/kyc/kyc_document.dart';
import 'package:fin_app/kyc/kyc_view_model.dart';
import 'package:fin_app/store/application_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_picker/image_picker.dart';

class KYCIdentityCard extends StatefulWidget {
  const KYCIdentityCard({super.key});

  @override
  State<KYCIdentityCard> createState() => _KYCIdentityCardState();
}

class _KYCIdentityCardState extends State<KYCIdentityCard> {
  final ImagePicker picker = ImagePicker();
  final List<XFile> uploadedImage = [];
  bool loading = false;

  updateUploadImage(XFile image) {
    setState(() {
      uploadedImage.add(image);
    });
  }

  showLoading() {
    setState(() {
      loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(
            color: Theme.of(context).primaryColor,
          ),
          title: const LinearProgressIndicator(
            minHeight: 10,
            semanticsLabel: "Login Information",
            value: .67,
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Upload a photo of your National ID Card",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    fontFamily: 'Urbanist'),
              ),
            ),
            if (uploadedImage.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 9.0),
                child: Text(
                  "Regulations require you to upload a national identity card. Don't worry, your data will stay safe and private",
                  style: TextStyle(fontSize: 18, fontFamily: 'Urbanist'),
                ),
              ),
            if (uploadedImage.isEmpty) const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                pickGalleryImage();
              },
              child: uploadedImage.isEmpty
                  ? SizedBox(
                      height: 200,
                      child: Card(
                        borderOnForeground: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                            side: BorderSide(
                                width: 4, color: Colors.orange.shade600)),
                        child: const Center(
                            child: SizedBox(
                                height: 65,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.image,
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
                    )
                  : SizedBox(
                      height: 350,
                      child: Image.file(File(uploadedImage.last.path))),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    child: Divider(
                  color: Colors.grey.shade300,
                  height: 10,
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "or",
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
                  ),
                ),
                Expanded(
                    child: Divider(
                  color: Colors.grey.shade300,
                  height: 40,
                ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: OutlinedButton.icon(
                onPressed: () {
                  pickCameraImage();
                },
                style: OutlinedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    side: const BorderSide(width: 2, color: Colors.orange)),
                icon: const Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.orange,
                ),
                label: Text(
                  "Open Camera and take photo",
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ),
            ),
            Expanded(
                child: Divider(
              color: Colors.grey.shade200,
            )),
            StoreConnector<ApplicationState, KYCViewModel>(
              converter: (store) => KYCViewModel.converter(store),
              builder: (context, viewModel) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                    onPressed: () {
                      if (uploadedImage.isNotEmpty) {
                        showLoading();
                        viewModel.uploadKYCImage(uploadedImage.last);
                        Future.delayed(
                            const Duration(milliseconds: 1500),
                            () => {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const KYCDocument()))
                                });
                      }
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
            )
          ],
        ),
      ),
    );
  }

  void pickGalleryImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      updateUploadImage(image);
    }
  }

  void pickCameraImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      updateUploadImage(image);
    }
  }
}
