import 'package:appify_lab_socm/data/remote/responses/api_response.dart';
import 'package:appify_lab_socm/models/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../res/api_constants/firebase_collection.dart';

class ProfileRepository{
  FirebaseAuth firebaseAuth;
  FirebaseFirestore firebaseFirestore;
  FirebaseStorage firebaseStorage;
  ProfileRepository({required this.firebaseAuth, required this.firebaseFirestore, required this.firebaseStorage});

  /*Stream<Object> myProfile(){
    final DocumentReference reference = firebaseFirestore.collection(FirebaseCollection.profile).doc(firebaseAuth.currentUser!.uid);
    return reference.snapshots().map((documentSnapshot) {
      if (documentSnapshot.exists) {
        final data = documentSnapshot.data() as Map<String, dynamic>;
        return Profile.fromJson(data);
      } else {
        // If the document does not exist, return a default or empty profile.
        return Failure(code: 404, error: {}, key: "my-profile");
      }
    });
  }*/

  Future<Object> myProfile()async{
    Object result = Failure(code: 404, error: {}, key: "my-profile");
    try{
      final DocumentReference reference = firebaseFirestore.collection(FirebaseCollection.profile).doc(firebaseAuth.currentUser!.uid);
      final DocumentSnapshot documentSnapshot = await reference.get();
      if(documentSnapshot.exists){
        result = Profile.fromJson(documentSnapshot.data() as Map<String, dynamic>);
      }
    }catch(e){
    }
    return result;
  }
  Future<Object> createProfile(User user)async{
    Object result = Failure(code: 404, error: {}, key: "my-profile");
    try{
      await firebaseFirestore.collection(FirebaseCollection.profile).doc(user.uid).set(Profile(email: user.email, uid: user.uid, username: null, profilePhoto: null).toJson());
      return Success(code: 200, data: {}, key: "my-profile");
    }catch(e){
    }
    return result;
  }

}