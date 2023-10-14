import 'package:appify_lab_socm/data/remote/responses/api_response.dart';
import 'package:appify_lab_socm/repositories/auth_repository.dart';
import 'package:appify_lab_socm/res/routes/named_routes.dart';
import 'package:appify_lab_socm/utils/toasts/error_toast.dart';
import 'package:appify_lab_socm/view_models/signin_provider/signin_generic.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';

class SignInState extends StateNotifier<SignInGeneric>{
  SignInState(this.authRepository):super(SignInGeneric(
      passwordController: TextEditingController(),
      emailController: TextEditingController(),
      isEmail: false,
    loading: false
  ));

  AuthRepository authRepository;
  checkIsEmail(){
    state = state.update(isEmail: EmailValidator.validate(state.emailController.text.trim()));
  }

  changeLoading(bool b){
    state = state.update(loading: b);
  }



  signIn(BuildContext context,String email, String password, bool isEmail)async{

    if(isEmail&&password.isNotEmpty){
      changeLoading(true);

      try{

        Object result  = await authRepository.signinWithEmailAndPassword(email, password);
        if(result is User){
          changeLoading(false);
          context.go(NamedRoutes.newsfeed);
        }else{
          errorToast("User not found");
        }
      }catch(e){
        errorToast("Input valid credentials");
      }

      changeLoading(false);
    }else{
      errorToast("Input valid credentials");
    }



  }
}