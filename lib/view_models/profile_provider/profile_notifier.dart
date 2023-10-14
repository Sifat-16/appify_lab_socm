import 'package:appify_lab_socm/models/profile.dart';
import 'package:appify_lab_socm/repositories/profile_repository.dart';
import 'package:appify_lab_socm/view_models/profile_provider/profile_generic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileState extends StateNotifier<ProfileGeneric>{
  ProfileState(this.profileRepository):super(ProfileGeneric(
    myProfile: null
  ));

  ProfileRepository profileRepository;

  fetchMyProfile()async{
    Object result = await profileRepository.myProfile();
    print(result.runtimeType);
    if(result is Profile){
      state = state.update(myProfile: result);
    }
  }


}