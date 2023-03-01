import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;
  File imageFile;

  Future<File> _takePicture(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile image = await _picker.pickImage(source: source);
    final File imageFile = File(image.path);

    if (imageFile == null) {
      return null;
    }
    setState(() {
      _storedImage = imageFile;
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
    return imageFile;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          children: [
            SizedBox(
              child: TextButton.icon(
                icon: Icon(Icons.camera),
                label: Text('Take Picture'),
                // textColor: Theme.of(context).primaryColor,
                onPressed: () => _takePicture(ImageSource.camera),
              ),
            ),
            SizedBox(
              child: TextButton.icon(
                icon: Icon(Icons.photo_library_sharp),
                label: Text('From gallery'),
                // textColor: Theme.of(context).primaryColor,
                onPressed: () => _takePicture(ImageSource.gallery),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
