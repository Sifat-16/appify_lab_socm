import 'package:appify_lab_socm/data/remote/responses/api_response.dart';
import 'package:appify_lab_socm/repositories/profile_repository.dart';
import 'package:appify_lab_socm/utils/toasts/error_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthRepository{
  FirebaseAuth firebaseAuth;
  ProfileRepository profileRepository;
  AuthRepository({required this.firebaseAuth, required this.profileRepository});


  Future<Object> signupWithEmailAndPassword(String email, String password)async{
    Object result = Failure(code: 404, error: {}, key: "sign-up");
    try{
      UserCredential credential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      result =  credential.user!;
      Object pr = await profileRepository.createProfile(credential.user!);

      if(pr is Success){

      }else{
        errorToast("Profile Creation failed");
      }

    }catch(e){
      errorToast("Signup failed");
    }
    return result;
  }

  Future<Object> signinWithEmailAndPassword(String email, String password)async{
    Object result = Failure(code: 404, error: {}, key: "sign-in");
    try{
      UserCredential credential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      result =  credential.user!;
    }catch(e){
      errorToast("Signin failed");
    }
    return result;
  }

  Future<Object> resetPassword(String trim) async{
    Object result = Failure(code: 404, error: {}, key: "reset-password-in");
    try{
      await firebaseAuth.sendPasswordResetEmail(email: trim);
      result =  Success(code: 200, data: {}, key: "key");
    }catch(e){
      errorToast("Password Reset failed");
    }
    return result;
  }

}