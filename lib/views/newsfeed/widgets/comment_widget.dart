

import 'package:appify_lab_socm/models/comment.dart';
import 'package:appify_lab_socm/models/posts.dart';
import 'package:appify_lab_socm/view_models/comment_provider/comment_generic.dart';
import 'package:appify_lab_socm/view_models/profile_provider/profile_generic.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommentTreeScreen extends ConsumerStatefulWidget {
  CommentTreeScreen({super.key, required this.commentUpdate, required this.commentDelete, required this.post});

  Function commentUpdate;
  Function commentDelete;
  Post post;

  @override
  ConsumerState<CommentTreeScreen> createState() => _CommentTreeScreenState();
}

class _CommentTreeScreenState extends ConsumerState<CommentTreeScreen> {

  FocusNode commentFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final cp = ref.watch(commentProvider);
    final profile = ref.watch(profileProvider);
    final cs = ref.watch(commentStream(widget.post));
    return Scaffold(
      backgroundColor: Colors.white,

      body: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          children: [

            cs.when(
                data: ((data){
                  return Expanded(
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index){
                          Comment comment = data[index].comment;
                          List<Comment> reply = data[index].reply;

                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: CommentTreeWidget<Comment, Comment>(
                              comment,
                              reply,
                              treeThemeData:
                              TreeThemeData(lineColor: Colors.green[500]!, lineWidth: 3),
                              avatarRoot: (context, data) => PreferredSize(
                                preferredSize: const Size.fromRadius(18),
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.grey,
                                  backgroundImage: NetworkImage('${data.owner!.profilePhoto}'),
                                ),
                              ),
                              avatarChild: (context, data) => PreferredSize(
                                preferredSize: const Size.fromRadius(12),
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.grey,
                                  backgroundImage: NetworkImage('${data.owner!.profilePhoto}'),
                                ),
                              ),
                              contentChild: (context, data) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius: BorderRadius.circular(12)),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: (){

                                                },
                                                child: Text(
                                                  '${data.owner!.email}',
                                                  style: Theme.of(context).textTheme.caption!.copyWith(
                                                      fontWeight: FontWeight.w600, color: Colors.black),
                                                ),
                                              ),
                                              Row(
                                                children: [

                                                  if(data.owner!.uid==profile.myProfile!.uid)
                                                    PopupMenuButton(
                                                      icon: const Icon(
                                                        Icons.more_horiz,

                                                      ),
                                                      itemBuilder: (context) => [

                                                        PopupMenuItem<int>(
                                                          value: 0,
                                                          child: Row(
                                                            children: [
                                                              Icon(Icons.edit),
                                                              Text("Edit"),
                                                            ],
                                                          ),
                                                        ),
                                                        PopupMenuItem<int>(
                                                          value: 1,
                                                          child: Row(
                                                            children: [
                                                              Icon(Icons.delete),
                                                              Text("Delete"),
                                                            ],
                                                          ),
                                                        ),

                                                      ],
                                                      onSelected: (value) {
                                                        if (value == 0) {
                                                          commentFocus.requestFocus();
                                                          ref.read(commentProvider.notifier).updateSelectedCommentToUpdate(data);

                                                        } else if (value == 1) {

                                                          ref.read(commentProvider.notifier).deleteComment(context, data, widget.post);

                                                        }
                                                      },
                                                    )
                                                  else
                                                    PopupMenuButton(
                                                      icon: const Icon(
                                                        Icons.more_horiz,

                                                      ),
                                                      itemBuilder: (context) => [

                                                        PopupMenuItem<int>(
                                                          value: 0,
                                                          child: Row(
                                                            children: [
                                                              Icon(Icons.flag),
                                                              Text("Report"),
                                                            ],
                                                          ),
                                                        ),


                                                      ],
                                                      onSelected: (value) {
                                                        if (value == 0) {


                                                        }
                                                      },
                                                    )
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            '${data.comment}',
                                            style: Theme.of(context).textTheme.caption?.copyWith(
                                                fontWeight: FontWeight.w300, color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                );
                              },
                              contentRoot: (context, data) {

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius: BorderRadius.circular(12)),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: (){

                                                },
                                                child: Text(
                                                  '${data.owner!.email}',
                                                  style: Theme.of(context).textTheme.caption!.copyWith(
                                                      fontWeight: FontWeight.w600, color: Colors.black),
                                                ),
                                              ),
                                              Row(
                                                children: [


                                                  if(data.owner!.uid==profile.myProfile!.uid)
                                                    PopupMenuButton(

                                                      icon: const Icon(
                                                        Icons.more_horiz,

                                                      ),

                                                      itemBuilder: (context) => [

                                                        PopupMenuItem<int>(
                                                          value: 0,
                                                          child: Row(
                                                            children: [
                                                              Icon(Icons.edit),
                                                              Text("Edit"),
                                                            ],
                                                          ),
                                                        ),
                                                        PopupMenuItem<int>(
                                                          value: 1,
                                                          child: Row(
                                                            children: [
                                                              Icon(Icons.delete),
                                                              Text("Delete"),
                                                            ],
                                                          ),
                                                        ),

                                                      ],
                                                      onSelected: (value) {
                                                        if (value == 0) {
                                                          commentFocus.requestFocus();
                                                          ref.read(commentProvider.notifier).updateSelectedCommentToUpdate(data);
                                                        } else if (value == 1) {
                                                          ref.read(commentProvider.notifier).deleteComment(context, data, widget.post);
                                                        }
                                                      },
                                                    )
                                                  else
                                                    PopupMenuButton(
                                                      icon: const Icon(
                                                        Icons.more_horiz,

                                                      ),
                                                      itemBuilder: (context) => [

                                                        PopupMenuItem<int>(
                                                          value: 0,
                                                          child: Row(
                                                            children: [
                                                              Icon(Icons.flag),
                                                              Text("Report"),
                                                            ],
                                                          ),
                                                        ),


                                                      ],
                                                      onSelected: (value) {
                                                        if (value == 0) {

                                                        }
                                                      },
                                                    )
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            '${data.comment}',
                                            style: Theme.of(context).textTheme.caption!.copyWith(
                                                fontWeight: FontWeight.w300, color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    DefaultTextStyle(
                                      style: Theme.of(context).textTheme.caption!.copyWith(
                                          color: Colors.grey[700], fontWeight: FontWeight.bold),
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 4),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 8,
                                            ),

                                            InkWell(
                                                onTap: (){
                                                  commentFocus.requestFocus();
                                                  ref.read(commentProvider.notifier).updateSelectedCommentToReply(data);

                                                },
                                                child: Text('Reply')
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),


                                  ],
                                );
                              },
                            ),
                          );
                        }),
                  );
                }),
                error: ((e, t){
                  return Center(child: Text("Failed"));
                }),
                loading: (){
                  return Center(child: CircularProgressIndicator(),);
                }
            ),





            Align(
              alignment: Alignment.bottomCenter,
              child: Container(

                decoration: BoxDecoration(
                    color: Colors.white
                ),
                child: Column(

                  children: [
                    SizedBox(height: 5,),
                    Divider(),
                    SizedBox(height: 5,),
                    if(cp.selectedCommentToReply!=null)
                      Column(
                        children: [
                          Row(
                            children: [

                              RichText(
                                text: TextSpan(text: "Replying to ",style: TextStyle(color: Colors.black), children: [
                                  TextSpan(
                                      text: "${cp.selectedCommentToReply!.owner!.email}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black
                                      )
                                  )
                                ]),
                              ),

                              TextButton(onPressed: (){
                                ref.read(commentProvider.notifier).updateSelectedCommentToReply(null);

                              }, child: Text("cancel"))

                            ],
                          ),
                          SizedBox(height: 5,),
                        ],
                      ),
                    if(cp.selectedCommentToUpdate!=null)
                      Column(
                        children: [
                          Row(
                            children: [

                              RichText(
                                text: TextSpan(text: "Update to ",style: TextStyle(color: Colors.black), children: [
                                  TextSpan(
                                      text: "${cp.selectedCommentToUpdate!.owner!.email}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black
                                      )
                                  )
                                ]),
                              ),

                              TextButton(onPressed: (){
                                ref.read(commentProvider.notifier).updateSelectedCommentToUpdate(null);

                              }, child: Text("cancel"))

                            ],
                          ),
                          SizedBox(height: 5,),
                        ],
                      ),

                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            maxLines: 4,
                            minLines: 1,
                            cursorHeight: 18,
                            autofocus: true,
                            focusNode: commentFocus,
                            onChanged: (s){
                              //rp.updateCanComment();
                            },
                            controller: cp.commentController,
                            decoration: InputDecoration(
                                hintText: "Add a comment ...",
                                contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30)

                                )
                            ),
                          ),
                        ),
                        IconButton(onPressed: (){
                          Comment comment;

                          if(cp.selectedCommentToUpdate!=null){
                            comment = cp.selectedCommentToUpdate!;
                            comment.comment = cp.commentController.text.trim();
                            ref.read(commentProvider.notifier).updateComment(context, comment, widget.post);
                          }else{
                            if(cp.selectedCommentToReply!=null){
                              comment = Comment(
                                  comment: cp.commentController.text.trim(),
                                  post: widget.post,
                                  owner: profile.myProfile,
                                  isReply: true,
                                  parentComment: cp.selectedCommentToReply!
                              );
                            }else{
                              comment = Comment(
                                  comment: cp.commentController.text.trim(),
                                  post: widget.post,
                                  owner: profile.myProfile,
                                  isReply: false,
                                  parentComment: null
                              );
                            }

                            ref.read(commentProvider.notifier).comment(context, comment, widget.post);
                          }



                        }, icon: Icon(Icons.send))
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    commentFocus.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}