import 'package:appify_lab_socm/data/remote/responses/api_response.dart';
import 'package:appify_lab_socm/dependency_providers/dependency_providers.dart';
import 'package:appify_lab_socm/models/posts.dart';
import 'package:appify_lab_socm/repositories/newsfeed_repository.dart';
import 'package:appify_lab_socm/res/constants/enums.dart';
import 'package:appify_lab_socm/res/routes/named_routes.dart';
import 'package:appify_lab_socm/utils/toasts/error_toast.dart';
import 'package:appify_lab_socm/utils/toasts/success_toast.dart';
import 'package:appify_lab_socm/view_models/newsfeed_provider/newsfeed_generic.dart';
import 'package:appify_lab_socm/views/create_post/create_post_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../models/profile.dart';
import '../../res/animation/tweens.dart';
import '../../views/newsfeed/widgets/comment_widget.dart';

class NewsfeedState extends StateNotifier<NewsfeedGeneric>{
  NewsfeedState(this.newsfeedRepository):super(NewsfeedGeneric(
    passwordController: TextEditingController(),
    emailController: TextEditingController(),
    isEmail: false,
    trackingScrollController: TrackingScrollController(),

  ));
  NewsfeedRepository newsfeedRepository;

  void editPost(BuildContext context, Post pst) {
    context.pop();
    Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => CreatePostScreen(type: CreatePostType.Update.value, post: pst,),
        transitionsBuilder: (context, animation, secondary, child){
          return SlideTransition(
            position: animation.drive(utbTweens()),
            child: child,
          );
    }
    ));

  }
  checkIsEmail(){
    state = state.update(isEmail: EmailValidator.validate(state.emailController.text.trim()));
  }



  void deletePost(BuildContext context, Post pst) async{
    print("delete");
    try{
      Object result = await newsfeedRepository.delete(pst);
      if(result is Success){
        context.pop();
        successToast('Post Deleted successfully');
      }
    }catch(e){
      context.pop();
    }
  }

  void like(BuildContext context, Post post, Profile myProfile) async{
    try{
      print('liked');
      Object result = await newsfeedRepository.like(post, myProfile);
      if(result is Failure){
        errorToast("like failed");
      }
    }catch(e){
      print(e);
    }
  }


  void showBottomSheetForComment(
      BuildContext context,
      Post post,
      ) async{

    showModalBottomSheet(
        useRootNavigator: true,
        useSafeArea: true,
        isScrollControlled: true,
        context: context, builder: (context){
      return  CommentTreeScreen(commentUpdate: (){

      }, commentDelete: (){}, post: post,);
    });
  }



}