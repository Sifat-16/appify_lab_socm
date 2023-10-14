import 'package:appify_lab_socm/res/routes/named_routes.dart';
import 'package:appify_lab_socm/res/theme/pallete.dart';
import 'package:appify_lab_socm/utils/common_widgets/criteria_text_field.dart';
import 'package:appify_lab_socm/utils/common_widgets/validation_text_field.dart';
import 'package:appify_lab_socm/utils/text_field_criteria_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../view_models/signup_provider/signup_generic.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {

  @override
  Widget build(BuildContext context) {

    final signUpProvider = ref.watch(signUpStateProvider);

    return  Container(
      decoration: BoxDecoration(
        gradient:  LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Palette.lightAccentBlueColor,
            Palette.lightBlueColor
          ])
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
        ),
        body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                        child: Image.asset("assets/images/appify_lab_icon.png", width: 60, height: 60,)
                    ),

                    SizedBox(height: 80,),
                    Column(
                      children: [


                        ValidationTextField(
                            label: "Email",
                            textEditingController: signUpProvider.emailController,
                            validateFunction: (s){
                              ref.read(signUpStateProvider.notifier).checkIsEmail();
                            },
                            validate: signUpProvider.isEmail
                        ),

                        SizedBox(height: 20,),

                        CriteriaTextField(
                          controller: signUpProvider.passwordController,
                          onChanged: (s){
                            ref.read(signUpStateProvider.notifier).updateCriteria();
                          },
                          heading: Text(
                            "Please create a secure password including the following criteria below",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.withOpacity(0.9)
                            ),
                          ),
                          labelText: 'Password',
                          criteria: [
                            TextFieldCriteriaCheck(
                                criteria: "Contain at least 8 characters",
                                succeed: signUpProvider.hasLengthCharacter
                            ),
                            TextFieldCriteriaCheck(
                                criteria: "Contain at least 1 number",
                                succeed: signUpProvider.hasLeastNumber
                            ),

                          ],

                        ),

                        SizedBox(height: 20,),

                        ValidationTextField(
                          label: "Confirm password",
                            textEditingController: signUpProvider.confirmPasswordController,
                            validateFunction: (s){
                              ref.read(signUpStateProvider.notifier).confirmPassword();
                            },
                            validate: signUpProvider.confirmPassword
                        ),


                        SizedBox(height: 20,),





                      ],
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: Palette.blueColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          )
                        ),
                            onPressed: ()async{
                              ref.read(signUpStateProvider.notifier).signup(context);
                            }, child: signUpProvider.loading?CircularProgressIndicator(color: Colors.white,): Text("Sign up")
                        ),
                    ),

                  ],
                ),
              ),
            )
        ),
      ),
    );
  }
}
