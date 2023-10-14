import 'package:appify_lab_socm/dependency_providers/dependency_providers.dart';
import 'package:appify_lab_socm/view_models/signup_provider/signup_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final signUpStateProvider = StateNotifierProvider.autoDispose<SignUpState, SignUpGeneric>((ref){

  ref.onDispose(() {

  });

  return SignUpState(ref.watch(authRepositoryProvider));

}

);

class SignUpGeneric{
  TextEditingController passwordController;
  TextEditingController emailController;
  TextEditingController confirmPasswordController;
  bool hasLengthCharacter;
  bool hasLeastNumber;
  bool isEmail;
  bool confirmPassword;
  bool loading;

  SignUpGeneric({
    required this.passwordController,
    required this.emailController,
    required this.hasLengthCharacter,
    required this.hasLeastNumber,
    required this.confirmPasswordController,
    required this.isEmail,
    required this.confirmPassword,
    required this.loading,
});

  SignUpGeneric update({
    TextEditingController? pcontroller,
    TextEditingController? econtroller,
    bool? hasLengthCharacter,
    bool? hasLeastNumber,
    TextEditingController? cpc,
    bool? isEmail,
    bool? confirmPassword,
    bool? loading,

}){
    return SignUpGeneric(
      passwordController: pcontroller??passwordController,
      emailController: econtroller??emailController,
      hasLengthCharacter: hasLengthCharacter??this.hasLengthCharacter,
      hasLeastNumber: hasLeastNumber??this.hasLeastNumber,
      confirmPasswordController: cpc??this.confirmPasswordController,
      isEmail: isEmail??this.isEmail,
      confirmPassword: confirmPassword??this.confirmPassword,
      loading: loading??this.loading
    );
  }
}