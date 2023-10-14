import 'dart:io';

import 'package:appify_lab_socm/dependency_providers/dependency_providers.dart';
import 'package:appify_lab_socm/view_models/profile_provider/profile_generic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'create_post_notifier.dart';
final createPostProvider = StateNotifierProvider.autoDispose<CreatePostState, CreatePostGeneric>((ref) {
  final myProfile = ref.watch(profileProvider).myProfile;
  final newsfeedRepository = ref.watch(newsfeedRepositoryProvider);
  return CreatePostState(myProfile, newsfeedRepository);
});

class CreatePostGeneric{

  TextEditingController description;
  bool loading;
  File? file;
  String fileType;
  String? background;
  String? imageUrl;

  CreatePostGeneric({
    required this.description,
    required this.loading,
    this.file,
    required this.fileType,
    this.background,
    this.imageUrl
  });

  CreatePostGeneric update({
    TextEditingController? description,
    bool? loading,
    File? file,
    String? fileType,
    String? background,
    String? imageUrl
}){
    return CreatePostGeneric(
        description: description??this.description,
        loading: loading??this.loading,
      file: file,
      fileType: fileType??this.fileType,
      background: background,
      imageUrl: imageUrl
    );
  }
}