import 'package:appify_lab_socm/dependency_providers/dependency_providers.dart';
import 'package:appify_lab_socm/models/posts.dart';
import 'package:appify_lab_socm/view_models/comment_provider/comment_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/comment.dart';
import '../newsfeed_provider/newsfeed_generic.dart';


final commentProvider = StateNotifierProvider.autoDispose<CommentState, CommentGeneric>((ref) {
  final np = ref.watch(newsfeedRepositoryProvider);
  return CommentState(np);
}
);

final commentStream = StreamProvider.family<List<CommentReplyObject>, Post>((ref, post) {
  final np = ref.watch(newsfeedRepositoryProvider);
  return np.postComments(post);
});

class CommentGeneric{

  bool loading;
  TextEditingController commentController;
  Comment? selectedCommentToReply;
  Comment? selectedCommentToUpdate;

  CommentGeneric({
    required this.loading,
    required this.commentController,
    this.selectedCommentToReply,
    this.selectedCommentToUpdate
});

  CommentGeneric update({
    TextEditingController? commentController,
    bool? loading,
    Comment? selectedCommentToReply,
    Comment? selectedCommentToUpdate
  }){
    return CommentGeneric(
        commentController: commentController??this.commentController,
        loading: loading??this.loading,
        selectedCommentToReply: selectedCommentToReply,
      selectedCommentToUpdate: selectedCommentToUpdate
    );
  }



}