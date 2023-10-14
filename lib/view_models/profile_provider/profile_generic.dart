import 'package:appify_lab_socm/dependency_providers/dependency_providers.dart';
import 'package:appify_lab_socm/view_models/profile_provider/profile_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/profile.dart';


final profileProvider = StateNotifierProvider<ProfileState, ProfileGeneric>((ref){

  final profileRepository = ref.watch(profileRepositoryProvider);

  return ProfileState(profileRepository);
}

);
class ProfileGeneric{
  Profile? myProfile;
  ProfileGeneric({
    this.myProfile
  });

  ProfileGeneric update({
    Profile? myProfile
}){
    return ProfileGeneric(
      myProfile: myProfile
    );
  }
}