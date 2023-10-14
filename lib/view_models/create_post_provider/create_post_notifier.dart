import 'dart:io';

import 'package:appify_lab_socm/data/remote/responses/api_response.dart';
import 'package:appify_lab_socm/models/posts.dart';
import 'package:appify_lab_socm/models/profile.dart';
import 'package:appify_lab_socm/res/constants/enums.dart';
import 'package:appify_lab_socm/utils/color_string_converter.dart';
import 'package:appify_lab_socm/utils/toasts/error_toast.dart';
import 'package:appify_lab_socm/utils/toasts/success_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../repositories/newsfeed_repository.dart';
import '../../res/routes/named_routes.dart';
import '../../utils/file_pick.dart';
import 'create_post_generic.dart';

class CreatePostState extends StateNotifier<CreatePostGeneric>{
  CreatePostState(this.myProfile, this.newsfeedRepository):super(CreatePostGeneric(
    description: TextEditingController(),
    loading: false,
    file: null,
    fileType: FileType.Image.value,
    background: null
  ));

  Profile? myProfile;
  NewsfeedRepository newsfeedRepository;

  pickImageFromGallery() async{
    state = state.update(fileType:FileType.Image.value, file:  await pickImage());

  }

  pickVideoFromGallery() async{
    state = state.update(fileType:FileType.Video.value, file:  await pickVideo());
  }

  updateBackgroundColor(Color? color){
    if(color==null){
      state = state.update(background: null);
    }else{
      state=state.update(background: colorToString(color));
    }
  }


  updateVariablesForEdit(Post post){
    try{
      state = state.update(
        description: TextEditingController(text: post.caption??""),
        background: post.backgroundColor,
        imageUrl: post.imageUrl
      );
    }catch(e){
      print(e);
    }
  }

  String checkValidity(File? file, String? backgroundColor, String text, String? imageUrl){
    try{

      if(file!=null&&text.isEmpty || imageUrl!=null&&text.isEmpty){
        print("Just Image");
        return PostType.Image.value;
      }
      if(file!=null&&text.isNotEmpty || imageUrl!=null&&text.isNotEmpty){
        print("Text Image");
        return PostType.TextWithImage.value;
      }
      if(file==null&&text.isNotEmpty){
        if(text.isNotEmpty&&backgroundColor==null){
          print("Just Text");
          return PostType.Text.value;
        }else{
          print("Background");
          return PostType.Background.value;
        }
      }
    }catch(e){
      print(e);
    }
    return "NONE";
  }

  changeLoading(bool b){
    state = state.update(loading: b);
  }

  createPost(BuildContext context, File? image, String? backgroundColor, String text) async{
    String type = checkValidity(image,backgroundColor,text, null);

    if(type!="NONE"){

      changeLoading(true);
      try{
        Post post = Post(
            user: myProfile,
            caption: text,
            postType: type,
            backgroundColor: backgroundColor,
            comments: 0,
            likes: 0,
            shares: 0
        );

        Object result = await newsfeedRepository.createPost(post, image: image);
        if(result is Success){
          context.pop();
          successToast("Post created successfully");
        }else{
          errorToast("Unable to create post");
        }
      }catch(e){

      }

      changeLoading(false);

    }else{
      errorToast('Post must be valid');
    }


  }

  void cancelImage() {
    state = state.update(file: null);
  }

  void cancelImageUrl() {
    state = state.update(imageUrl: null);
  }

  void updatePost(
      BuildContext context,
      File? file,
      String? background,
      String trim,
      String? imageUrl,
      Post post
      ) async{
    String type = checkValidity(file,background,trim, imageUrl);

    if(type!='NONE'){
      changeLoading(true);
      try{

        post.caption = trim;
        post.postType = type;
        post.backgroundColor = background;
        post.imageUrl = imageUrl;


        Object result = await newsfeedRepository.updatePost(post, image: file);
        if(result is Success){
          context.pop();
          successToast("Post updated successfully");
        }else{
          errorToast("Unable to update post");
        }
      }catch(e){

      }

      changeLoading(false);
    }

  }


}