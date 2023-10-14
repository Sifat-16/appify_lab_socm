import 'package:appify_lab_socm/dependency_providers/dependency_providers.dart';
import 'package:appify_lab_socm/models/posts.dart';
import 'package:appify_lab_socm/models/profile.dart';
import 'package:appify_lab_socm/view_models/newsfeed_provider/newsfeed_notifier.dart';
import 'package:appify_lab_socm/view_models/signin_provider/signin_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final newsfeedProvider = StateNotifierProvider<NewsfeedState, NewsfeedGeneric>((ref){
  final newsp = ref.watch(newsfeedRepositoryProvider);
  return NewsfeedState(newsp);
}
);

final allPostStreamProvider = StreamProvider<List<Post>>((ref) {
  final newsFeedRepository = ref.watch(newsfeedRepositoryProvider);
  return newsFeedRepository.allPosts();
});

final myLikeProvider = StreamProvider.family<List<Profile>, Post>((ref, post) {
  final newsFeedRepository = ref.watch(newsfeedRepositoryProvider);
  return newsFeedRepository.likeStream(post);

});

class NewsfeedGeneric{
  TextEditingController passwordController;
  TextEditingController emailController;
  TrackingScrollController trackingScrollController;
  bool isEmail;


  NewsfeedGeneric({
    required this.passwordController,
    required this.emailController,
    required this.isEmail,
    required this.trackingScrollController
  });

  NewsfeedGeneric update({
    TextEditingController? pcontroller,
    TextEditingController? econtroller,

    bool? isEmail,
    TrackingScrollController? trackingScrollController,



  }){
    return NewsfeedGeneric(
      passwordController: pcontroller??passwordController,
      emailController: econtroller??emailController,
      isEmail: isEmail??this.isEmail,
      trackingScrollController: trackingScrollController??this.trackingScrollController
    );
  }
}