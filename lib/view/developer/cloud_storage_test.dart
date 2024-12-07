import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class CloudStorageTest extends StatefulWidget {
  @override
  State<CloudStorageTest> createState() => _CloudStorageTestState();
}

class _CloudStorageTestState extends State<CloudStorageTest> {
  final storageRef = FirebaseStorage.instance.ref();
  final ImagePicker _picker = ImagePicker();
  late final Reference battarikunRef;
  late final Reference iconRef;

  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    battarikunRef = storageRef.child("battarikun.png");
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.create(recursive: true);
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
        debugPrint('Image selected: ${image.path}');
      } else {
        debugPrint('No image selected.');
      }
    } catch (e) {
      debugPrint('Error selecting image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            Column(
              children: [
                Image.asset('assets/images/battarikun.png'),
                TextButton(
                    onPressed: () async {
                      File file = await getImageFileFromAssets(
                          'assets/images/battarikun.png');
                      await battarikunRef.putFile(file);
                      debugPrint(await battarikunRef.getDownloadURL());
                    },
                    child: Text("battarikunファイル送信")),
                TextButton(
                  onPressed: _pickImage,
                  child: Text("画像選択"),
                ),
                // 選択した画像を表示するウィジェット
                if (_selectedImage != null) ...[
                  SizedBox(height: 20),
                  Text("選択した画像:"),
                  Image.file(
                    _selectedImage!,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  TextButton(
                    onPressed: () async {
                      if (_selectedImage != null) {
                        File file = _selectedImage!; // 直接ファイルを取得
                        String fileName = file.path.split('/').last; // ファイル名を取得
                        iconRef = FirebaseStorage.instance.ref(fileName);

                        // ファイルの存在を確認
                        if (file.existsSync()) {
                          await iconRef.putFile(file);
                          String downloadUrl =
                              (await iconRef.getDownloadURL()).split('&').first;

                          debugPrint('Uploaded URL: $downloadUrl');
                        }
                      }
                    },
                    child: Text('アイコン写真決定'),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
