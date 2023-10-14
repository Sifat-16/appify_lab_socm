
import 'package:appify_lab_socm/dependency_providers/dependency_providers.dart';
import 'package:appify_lab_socm/models/profile.dart';
import 'package:appify_lab_socm/res/constants/enums.dart';
import 'package:appify_lab_socm/utils/color_string_converter.dart';
import 'package:appify_lab_socm/utils/common_widgets/reusable_reaction_button.dart';
import 'package:appify_lab_socm/utils/dialogs/delete_confirmation_dialog.dart';
import 'package:appify_lab_socm/utils/reactions/emoji_reactions.dart';
import 'package:appify_lab_socm/view_models/newsfeed_provider/newsfeed_generic.dart';
import 'package:appify_lab_socm/view_models/profile_provider/profile_generic.dart';
import 'package:appify_lab_socm/views/newsfeed/widgets/profile_avatar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../models/posts.dart';
import '../../../res/theme/pallete.dart';

class PostContainer extends StatelessWidget {
  final Post post;
  Function(BuildContext, Post) edit;
  Function(BuildContext, Post) delete;
  Function(BuildContext, Post, Profile) like;
  Function(BuildContext, Post) comment;

   PostContainer({
    required this.post,
    required this.edit,
    required this.delete,
     required this.like,
     required this.comment
  }) : super();

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 0.0,
      ),
      elevation: 0.0,

      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _PostHeader(post: post, openBottomSheet: () { 
                    bottomSheetPassData(context, edit , delete, post);
                  },),
                  const SizedBox(height: 15.0),
                  if(post.postType!=PostType.Background.value)
                    Text(post.caption??"")
                  else
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*.4,
                      decoration: BoxDecoration(
                        color: stringToColor(post.backgroundColor!)
                      ),
                      child: Center(
                        child: Text("${post.caption}", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),),
                      ),
                    ),
                  post.imageUrl != null
                      ? const SizedBox.shrink()
                      : const SizedBox(height: 6.0),
                ],
              ),
            ),

            if(post.postType!=PostType.Background.value)
              post.imageUrl != null
                  ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CachedNetworkImage(imageUrl: post.imageUrl!),
              )
                  : const SizedBox.shrink(),

            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: _PostStats(post: post, like: like,comment: comment,),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostHeader extends ConsumerWidget {
  final Post post;
  final VoidCallback openBottomSheet;

   _PostHeader({

    required this.post,
     required this.openBottomSheet
  }) : super();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(firebaseAuthProvider);
    return Row(
      children: [
        ProfileAvatar(imageUrl: post.user!.profilePhoto),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.user!.email??"",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  /*Text(
                    '${post.timeAgo} • ',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.0,
                    ),
                  ),*/
                  Icon(
                    Icons.public,
                    color: Colors.grey[600],
                    size: 12.0,
                  )
                ],
              ),
            ],
          ),
        ),
        if(post.user!.uid==auth.currentUser!.uid)
          IconButton(
          icon: const Icon(Icons.more_horiz),
          onPressed: openBottomSheet,
        ),
      ],
    );
  }
}

class _PostStats extends ConsumerWidget {
  final Post post;

  Function(BuildContext, Post, Profile) like;
  Function(BuildContext, Post) comment;
   _PostStats({

    required this.post,
     required this.like,
     required this.comment

  }) : super();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pp = ref.watch(profileProvider);
    final lp = ref.watch(myLikeProvider(post));
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Palette.blueColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.thumb_up,
                size: 10.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 4.0),
            Expanded(
              child: Text(
                '${post.likes}',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
            Text(
              '${post.comments} Comments',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              '${post.shares} Shares',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            )
          ],
        ),
        const Divider(),
        Row(
          children: [


            _PostButton(
              icon: lp.when(
                  data: ((data){

                    if(data.indexWhere((element) => element.uid==pp.myProfile!.uid)!=-1){
                      return Icon(
                        MdiIcons.thumbUp,
                        color: Palette.blueColor,
                        size: 20.0,
                      );
                    }
                    return Icon(
                      MdiIcons.thumbUpOutline,
                      color: Colors.grey[600],
                      size: 20.0,
                    );
                  }),
                  error: ((ctx, e){
                    return Icon(Icons.error);
                  }),
                  loading: (){
                    return Icon(Icons.padding, color: Colors.white,);
                  }
              ),
              label: 'Like',
              onTap: () {
                like(context, post, pp.myProfile!);
              },
            ),
            _PostButton(
              icon: Icon(
                MdiIcons.commentOutline,
                color: Colors.grey[600],
                size: 20.0,
              ),
              label: 'Comment',
              onTap: () {
                comment(context, post);
              },
            ),
            _PostButton(
              icon: Icon(
                MdiIcons.shareOutline,
                color: Colors.grey[600],
                size: 25.0,
              ),
              label: 'Share',
              onTap: () => print('Share'),
            )
          ],
        ),
      ],
    );
  }
}

class _PostButton extends ConsumerWidget {
  final Icon icon;
  final String label;
  final Function onTap;

   _PostButton({

    required this.icon,
    required this.label,
    required this.onTap,
  }) : super();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: (){
            onTap();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 25.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 4.0),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

bottomSheetPassData(BuildContext context, Function(BuildContext, Post) edit, Function(BuildContext, Post) delete, Post post){
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit'),
              onTap: (){

                edit(context, post);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Delete'),
              onTap: () {
                showDeleteConfirmationDialog(context, (){
                  delete(context, post);
                });// Close the bottom sheet
              },
            ),
          ],
        ),
      );
    },
  );
}