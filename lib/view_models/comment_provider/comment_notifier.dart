
import 'package:appify_lab_socm/data/remote/responses/api_response.dart';
import 'package:appify_lab_socm/models/comment.dart';
import 'package:appify_lab_socm/repositories/newsfeed_repository.dart';
import 'package:appify_lab_socm/utils/toasts/error_toast.dart';
import 'package:appify_lab_socm/view_models/comment_provider/comment_generic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/posts.dart';
import '../../models/profile.dart';

class CommentState extends StateNotifier<CommentGeneric>{
  CommentState(this.newsfeedRepository):super(CommentGeneric(
      loading: false,
      commentController: TextEditingController(),
    selectedCommentToReply: null
  ));

  NewsfeedRepository newsfeedRepository;


  updateSelectedCommentToReply(Comment? comment){
    state = state.update(selectedCommentToReply: comment, selectedCommentToUpdate: null);
  }

  updateSelectedCommentToUpdate(Comment? comment){
    if(comment==null){
      state = state.update(selectedCommentToUpdate: comment, selectedCommentToReply: null, commentController: TextEditingController());
    }else{
      state = state.update(selectedCommentToUpdate: comment, commentController: TextEditingController(text: comment.comment), selectedCommentToReply: null);

    }
  }

  checkValidity(Comment comment){
    try{
      return comment.comment!.isNotEmpty;
    }catch(e){

    }
    return false;

  }

  void comment(BuildContext context, Comment comment, Post post) async{
    if(checkValidity(comment)){
      try{
        Object result = await newsfeedRepository.createComment(post, comment);
        if(result is Success){
          state = state.update(commentController: TextEditingController());
        }
      }catch(e){
      }
    }else{
      errorToast("Invalid comment");
    }

  }

  updateComment(BuildContext context, Comment comment, Post post)async{
    if(checkValidity(comment)){
      try{
        Object result = await newsfeedRepository.updateComment(post, comment);
        if(result is Success){
          updateSelectedCommentToUpdate(null);
        }
      }catch(e){
      }
    }else{
      errorToast("Invalid comment");
    }
  }

  void deleteComment(BuildContext context, Comment comment, Post post) async{
    try{
      Object result = await newsfeedRepository.deleteComment(post, comment);
    }catch(e){
    }
  }


}