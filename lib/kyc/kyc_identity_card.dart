import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class KYCIdentityCard extends StatelessWidget {
  final ImagePicker picker = ImagePicker();

  KYCIdentityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: false,
        title: const Text("ID Card upload"),
      ),
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
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 9.0),
              child: Text(
                "Regulations require you to upload a national identity card. Don't worry, your data will stay safe and private",
                style: TextStyle(fontSize: 18, fontFamily: 'Urbanist'),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                pickGalleryImage();
              },
              child: SizedBox(
                height: 200,
                child: Card(
                  borderOnForeground: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                      side:
                          BorderSide(width: 4, color: Colors.orange.shade600)),
                  child: const Center(
                      child: SizedBox(
                          height: 65,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              ),
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
            const SizedBox(
              height: 10,
            ),
            OutlinedButton.icon(
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
            Expanded(
                child: Divider(
              color: Colors.grey.shade200,
              height: 40,
            )),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    minimumSize: const Size(250, 50),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                        color: Colors.white,
                      fontSize: 18
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  void pickGalleryImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    print(image);
  }

  void pickCameraImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    print(image);
  }
}
