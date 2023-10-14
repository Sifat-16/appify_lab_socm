import 'package:appify_lab_socm/dependency_providers/dependency_providers.dart';
import 'package:appify_lab_socm/res/constants/enums.dart';
import 'package:appify_lab_socm/res/routes/named_routes.dart';
import 'package:appify_lab_socm/view_models/create_post_provider/create_post_generic.dart';
import 'package:appify_lab_socm/view_models/newsfeed_provider/newsfeed_generic.dart';
import 'package:appify_lab_socm/view_models/profile_provider/profile_generic.dart';
import 'package:appify_lab_socm/views/newsfeed/widgets/circle_button.dart';
import 'package:appify_lab_socm/views/newsfeed/widgets/create_post_container.dart';
import 'package:appify_lab_socm/views/newsfeed/widgets/post_container.dart';
import 'package:appify_lab_socm/views/newsfeed/widgets/room_container.dart';
import 'package:appify_lab_socm/views/newsfeed/widgets/stories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../models/posts.dart';
import '../../models/profile.dart';
import '../../res/theme/pallete.dart';

class NewsFeedScreen extends ConsumerStatefulWidget {
  const NewsFeedScreen({super.key});

  @override
  ConsumerState<NewsFeedScreen> createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends ConsumerState<NewsFeedScreen> {


  @override
  void initState() {
    // TODO: implement initState

    final pp = ref.read(profileProvider.notifier);
    pp.fetchMyProfile();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    final nfp = ref.watch(newsfeedProvider);
    final allPosts = ref.watch(allPostStreamProvider);
    final pp = ref.watch(profileProvider);
    final auth = ref.watch(firebaseAuthProvider);

    return Scaffold(
      body: CustomScrollView(
        controller: nfp.trackingScrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            title: Text(
              'AppifyLab',
              style:  TextStyle(
                color: Palette.paleBlueColor,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.2,
              ),
            ),
            centerTitle: false,
            floating: true,
            actions: [
              CircleButton(
                icon: Icons.search,
                iconSize: 25.0,
                onPressed: () {

                },
              ),
              CircleButton(
                icon: MdiIcons.logout,
                iconSize: 25.0,
                onPressed: () {
                  print("logout");
                  auth.signOut().then((value) {
                    context.go(NamedRoutes.signin);
                  });


                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: CreatePostContainer(
              currentUser: pp.myProfile,
              onTapAvatar: (){

              },
              onTapCreate: (){

                context.push(NamedRoutes.createpost, extra: CreatePostType.Create.value);

              },
          ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
            sliver: SliverToBoxAdapter(
              child: Rooms(onlineUsers: []),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
            sliver: SliverToBoxAdapter(
              child: Stories(
                currentUser: pp.myProfile,
                stories: [],
              ),
            ),
          ),
          allPosts.when(
              data: ((data){
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          Post post = data[index];
                      return PostContainer(
                          post: post,
                          edit: ref.read(newsfeedProvider.notifier).editPost,
                          delete: ref.read(newsfeedProvider.notifier).deletePost,
                          like: ref.read(newsfeedProvider.notifier).like,
                        comment: ref.read(newsfeedProvider.notifier).showBottomSheetForComment,
                      );
                    },
                    childCount: data.length,
                  ),
                );
              }),
              error: ((e, t){
                return SliverToBoxAdapter(child:Text("Error"));
              }),
              loading: (){
                return SliverToBoxAdapter( child:Center(child: CircularProgressIndicator(),));
              }
          )

        ],
      ),
    );
  }
}
