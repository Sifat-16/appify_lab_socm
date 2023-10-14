import 'package:appify_lab_socm/models/profile.dart';
import 'package:appify_lab_socm/views/newsfeed/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';

class CreatePostContainer extends StatelessWidget {
  Profile? currentUser;

  Function onTapCreate;
  Function onTapAvatar;

   CreatePostContainer({
    required this.currentUser,
     required this.onTapAvatar,
     required this.onTapCreate
  }) : super();

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 0.0),
      elevation: 0.0,
      shape: null,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: (){
                    onTapAvatar();
                  },
                    child: ProfileAvatar(imageUrl: currentUser==null?null:currentUser!.profilePhoto)),
                const SizedBox(width: 8.0),
                Expanded(
                  child: InkWell(
                    onTap: (){
                      onTapCreate();
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      height: 35,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("What\'s on your mind?"),
                      ),
                    ),
                  ),

                )
              ],
            ),


          ],
        ),
      ),
    );
  }
}