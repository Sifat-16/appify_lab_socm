import 'package:appify_lab_socm/data/remote/responses/api_response.dart';
import 'package:appify_lab_socm/repositories/auth_repository.dart';
import 'package:appify_lab_socm/res/routes/named_routes.dart';
import 'package:appify_lab_socm/utils/toasts/error_toast.dart';
import 'package:appify_lab_socm/view_models/signup_provider/signup_generic.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUpState extends StateNotifier<SignUpGeneric>{
  SignUpState(this.authRepository):super(SignUpGeneric(
    passwordController: TextEditingController(),
    emailController: TextEditingController(),
    hasLengthCharacter: false,
    hasLeastNumber: false,
    confirmPasswordController: TextEditingController(),
    isEmail: false,
    confirmPassword: false,
    loading: false
  ));

  AuthRepository authRepository;

  updateCriteria(){
    containsLengthCharacters();
    containsNumber();
  }
  changeLoading(bool b){
    state = state.update(loading: b);
  }

  containsLengthCharacters(){
    if(state.passwordController.text.length>=8){
      state = state.update(hasLengthCharacter: true);
    }else{
      state = state.update(hasLengthCharacter: false);
    }

  }

  containsNumber(){
    final numeric = RegExp(r'[0-9]');
    if(numeric.hasMatch(state.passwordController.text)){
      state = state.update(hasLeastNumber: true);
    }else{
      state = state.update(hasLeastNumber: false);
    }
  }

  checkIsEmail(){
    state = state.update(isEmail: EmailValidator.validate(state.emailController.text.trim()));
  }

  confirmPassword(){
    state = state.update(confirmPassword: state.passwordController.text.trim()==state.confirmPasswordController.text.trim());
  }

  bool checkValidity(){
    if(!state.isEmail){
      errorToast("Must put a valid email address");
      return false;
    }
    if(!state.hasLengthCharacter||!state.hasLeastNumber){
      errorToast("Password must fill up the criteria");
      return false;
    }
    if(!state.confirmPassword){
      errorToast("Confirm password did not match");
      return false;
    }
    return true;
  }

  signup(BuildContext context)async{
    if(checkValidity()){
      changeLoading(true);
      try{
        Object result = await authRepository.signupWithEmailAndPassword(state.emailController.text.trim(), state.passwordController.text.trim());
        if(result is User){
          changeLoading(false);
          context.go(NamedRoutes.newsfeed);
        }
      }catch(e){

      }
      changeLoading(false);

    }


  }




}