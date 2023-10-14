import 'package:appify_lab_socm/data/remote/responses/api_response.dart';
import 'package:appify_lab_socm/utils/toasts/error_toast.dart';
import 'package:appify_lab_socm/utils/toasts/success_toast.dart';
import 'package:appify_lab_socm/view_models/forgot_password_provider/forgot_password_generic.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../repositories/auth_repository.dart';

class ForgotPasswordState extends StateNotifier<ForgotPasswordGeneric>{
  ForgotPasswordState(this.authRepository):super(ForgotPasswordGeneric(emailController: TextEditingController(), isEmail: false, loading: false));


  AuthRepository authRepository;
  checkIsEmail(){
    state = state.update(isEmail: EmailValidator.validate(state.emailController.text.trim()));
  }

  changeLoading(bool b){
    state = state.update(loading: b);
  }

  void verifyMail(BuildContext context, String trim, bool isEmail) async{
    if(isEmail){
      Object result = await authRepository.resetPassword(trim);

      if(result is Success){
        successToast("Please check your email");
        context.pop();
      }
    }else{
      errorToast("Please enter valid email");
    }
  }

}