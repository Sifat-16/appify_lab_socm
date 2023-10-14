import 'package:appify_lab_socm/models/profile.dart';
import 'package:appify_lab_socm/views/newsfeed/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';

import '../../../res/theme/pallete.dart';

class Rooms extends StatelessWidget {
  final List<Profile> onlineUsers;
  const Rooms({
    required this.onlineUsers,
  }) : super();

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 0.0),
      elevation: 0.0,

      child: Container(
        height: 60.0,
        color: Colors.white,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 4.0,
          ),
          scrollDirection: Axis.horizontal,
          itemCount: 1 + onlineUsers.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: _CreateRoomButton(),
              );
            }
            final Profile user = onlineUsers[index - 1];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ProfileAvatar(
                imageUrl: user.profilePhoto,
                isActive: true,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CreateRoomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => print('Create Room'),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        backgroundColor: Colors.white,
        side: BorderSide(
          width: 3.0,
          color: Colors.blueAccent.shade100,
        ),
        textStyle: TextStyle(
          color: Palette.blueColor
        ),
      ),

      child: Row(
        children: [

          Icon(
            Icons.video_call,
            size: 35.0,
            color: Colors.purple,
          ),
          const SizedBox(width: 4.0),
          Text('Create\nRoom'),
        ],
      ),
    );
  }
}