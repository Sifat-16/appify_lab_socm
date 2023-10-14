import 'dart:io';

import 'package:appify_lab_socm/res/constants/enums.dart';
import 'package:appify_lab_socm/views/create_post/widgets/video_view.dart';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  ImageView({
    Key? key,
    required this.fileType,
    required this.file,
     required this.onCancel
  }) : super(key: key);

  String fileType;
  File file;
  Function onCancel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (fileType == FileType.Image.value)
          Image.file(file)
        else
          VideoView(
            video: file,
          ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(onPressed: (){
            onCancel();
          }, icon: Icon(Icons.clear)),
        )
      ],
    );

  }
}

class ImageViewNetwork extends StatelessWidget {
  ImageViewNetwork({
    Key? key,
    required this.fileType,
    required this.file,
    required this.onCancel
  }) : super(key: key);

  String fileType;
  String file;
  Function onCancel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(file),

        Align(
          alignment: Alignment.topRight,
          child: IconButton(onPressed: (){
            onCancel();
          }, icon: Icon(Icons.clear)),
        )
      ],
    );

  }
}