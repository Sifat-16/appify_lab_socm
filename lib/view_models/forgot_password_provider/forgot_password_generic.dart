import 'package:appify_lab_socm/view_models/forgot_password_provider/forgot_password_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dependency_providers/dependency_providers.dart';

final forgotPasswordProvider = StateNotifierProvider<ForgotPasswordState, ForgotPasswordGeneric>((ref) {
  final authRep = ref.watch(authRepositoryProvider);
  return ForgotPasswordState(authRep);
});

class ForgotPasswordGeneric{

  TextEditingController emailController;
  bool isEmail;
  bool loading;

  ForgotPasswordGeneric({

    required this.emailController,
    required this.isEmail,
    required this.loading
  });

  ForgotPasswordGeneric update({
    TextEditingController? pcontroller,
    TextEditingController? econtroller,

    bool? isEmail,
    bool? loading


  }){
    return ForgotPasswordGeneric(

        emailController: econtroller??emailController,
        isEmail: isEmail??this.isEmail,
        loading: loading??this.loading

    );
  }
}