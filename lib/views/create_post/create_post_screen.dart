import 'dart:io';

import 'package:appify_lab_socm/res/constants/enums.dart';
import 'package:appify_lab_socm/res/theme/pallete.dart';
import 'package:appify_lab_socm/utils/color_picker.dart';
import 'package:appify_lab_socm/utils/color_string_converter.dart';
import 'package:appify_lab_socm/view_models/create_post_provider/create_post_generic.dart';
import 'package:appify_lab_socm/views/create_post/widgets/image_video_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../models/posts.dart';
import '../../utils/file_pick.dart';
import '../../view_models/profile_provider/profile_generic.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
   CreatePostScreen({super.key, required this.type, this.post});

   String type;
   Post? post;

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {


  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(widget.type==CreatePostType.Update.value){
        ref.read(createPostProvider.notifier).updateVariablesForEdit(widget.post!);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.type);

    final pp = ref.watch(profileProvider);
    final cp = ref.watch(createPostProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          if(widget.type==CreatePostType.Create.value)
            TextButton(
              onPressed: (){
                ref.read(createPostProvider.notifier).createPost(context, cp.file, cp.background, cp.description.text.trim());
              },
              child:  cp.loading?Center(child: SizedBox(
                height: 30,
                  width: 30,
                  child: CircularProgressIndicator()),):Text('Post'),
            )
          else
            TextButton(
              onPressed: (){
                ref.read(createPostProvider.notifier).updatePost(context, cp.file, cp.background, cp.description.text.trim(), cp.imageUrl, widget.post!);
              },
              child:  cp.loading?Center(child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator()),):Text('Update'),
            )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("${pp.myProfile!.profilePhoto}"),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${pp.myProfile!.email}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Text(
                    'Public',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  )
                ],
              )
            ],
          ),

              SizedBox(height: 20,),
              // post text field
              cp.background==null?TextField(
                controller: cp.description,
                decoration:  InputDecoration(
                  border: InputBorder.none,
                  hintText: 'What\'s on your mind?',
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Palette.darkGreyColor,
                  ),
                ),
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 10,
              ):Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: cp.description,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                    decoration:  InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: stringToColor(cp.background!),

                      hintText: 'What\'s on your mind?',
                      hintStyle: TextStyle(
                        fontSize: 18,
                        color: Palette.darkGreyColor,
                      ),
                    ),
                    keyboardType: TextInputType.multiline,

                    maxLines: 10,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if(widget.type==CreatePostType.Create.value)
                cp.file != null
                    ? ImageView(
                  file: cp.file!,
                  fileType: cp.fileType,
                  onCancel: (){
                    ref.read(createPostProvider.notifier).cancelImage();
                  },
                )
                    : PickFileWidget(
                  pickImage: () async {
                    ref.read(createPostProvider.notifier).pickImageFromGallery();
                  },
                  pickColor: () async {

                    Color c = await colorPickerDialog(context, cp.background==null? Color(0xff2196f3):stringToColor(cp.background!));

                    ref.read(createPostProvider.notifier).updateBackgroundColor(c);

                  }, removeColor: () {
                  ref.read(createPostProvider.notifier).updateBackgroundColor(null);
                }, showRemove: cp.background!=null,
                )
              else
                if(cp.file==null&&cp.imageUrl==null)
                  PickFileWidget(
                    pickImage: () async {
                      ref.read(createPostProvider.notifier).pickImageFromGallery();
                    },
                    pickColor: () async {

                      Color c = await colorPickerDialog(context, cp.background==null? Color(0xff2196f3):stringToColor(cp.background!));

                      ref.read(createPostProvider.notifier).updateBackgroundColor(c);

                    }, removeColor: () {
                    ref.read(createPostProvider.notifier).updateBackgroundColor(null);
                  }, showRemove: cp.background!=null,
                  )
                else
                  if(cp.file!=null)
                    ImageView(
                      file: cp.file!,
                      fileType: cp.fileType,
                      onCancel: (){
                        ref.read(createPostProvider.notifier).cancelImage();
                      },
                    )
                  else
                    ImageViewNetwork(
                        fileType: FileType.Image.value,
                        file: cp.imageUrl!,
                        onCancel: (){
                          ref.read(createPostProvider.notifier).cancelImageUrl();
                        }
                    ),





              const SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }


}

class PickFileWidget extends StatelessWidget {
  const PickFileWidget({
    super.key,
    required this.pickImage,
    required this.pickColor,
    required this.removeColor,
    required this.showRemove
  });

  final VoidCallback pickImage;
  final VoidCallback pickColor;
  final VoidCallback removeColor;
  final bool showRemove;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: pickImage,
          child: Row(
            children: [
              Icon(MdiIcons.imageAlbum, color: Colors.red, size: 18,),
              SizedBox(width: 8,),
              const Text('Pick Image'),
            ],
          ),
        ),
        const Divider(),
        TextButton(
          onPressed: pickColor,
          child: Row(
            children: [
              Icon(MdiIcons.alphaABox, color: Colors.red, size: 18, ),
              SizedBox(width: 8,),
              const Text('Background Color'),
            ],
          ),
        ),
          if(showRemove)
            Column(
              children: [
                const Divider(),
                TextButton(
                  onPressed: removeColor,
                  child: Row(
                    children: [
                      Icon(MdiIcons.delete, color: Colors.red, size: 18, ),
                      SizedBox(width: 8,),
                      const Text('Remove Color'),
                    ],
                  ),
                ),
              ],
            )

      ],
    );
  }
}
