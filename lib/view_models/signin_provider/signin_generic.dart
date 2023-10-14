import 'package:appify_lab_socm/dependency_providers/dependency_providers.dart';
import 'package:appify_lab_socm/view_models/signin_provider/signin_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signInStateProvider = StateNotifierProvider.autoDispose<SignInState, SignInGeneric>((ref){

  ref.onDispose(() {

  });
  final authRepository = ref.watch(authRepositoryProvider);

  return SignInState(authRepository);
}

);

class SignInGeneric{
  TextEditingController passwordController;
  TextEditingController emailController;
  bool isEmail;
  bool loading;

  SignInGeneric({
    required this.passwordController,
    required this.emailController,
    required this.isEmail,
    required this.loading
  });

  SignInGeneric update({
    TextEditingController? pcontroller,
    TextEditingController? econtroller,

    bool? isEmail,
    bool? loading


  }){
    return SignInGeneric(
        passwordController: pcontroller??passwordController,
        emailController: econtroller??emailController,
        isEmail: isEmail??this.isEmail,
      loading: loading??this.loading

    );
  }
}