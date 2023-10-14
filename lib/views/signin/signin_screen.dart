import 'package:appify_lab_socm/res/routes/named_routes.dart';
import 'package:appify_lab_socm/view_models/signin_provider/signin_generic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../res/theme/pallete.dart';
import '../../utils/common_widgets/validation_text_field.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {

  @override
  Widget build(BuildContext context) {
    final signInProvider = ref.watch(signInStateProvider);
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
                            textEditingController: signInProvider.emailController,
                            validateFunction: (s){
                              ref.read(signInStateProvider.notifier).checkIsEmail();
                            },
                            validate: signInProvider.isEmail
                        ),

                        SizedBox(height: 20,),

                        TextField(
                          controller: signInProvider.passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
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
                          onPressed: (){
                            ref.read(signInStateProvider.notifier).signIn(context,
                                signInProvider.emailController.text.trim()
                                , signInProvider.passwordController.text.trim(),
                                signInProvider.isEmail
                            );
                          }, child: signInProvider.loading?Center(child: CircularProgressIndicator(color: Colors.white,),): Text("Log in")
                      ),
                    ),
                    SizedBox(height: 40,),

                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Palette.blueColor,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        )
                      ),
                        onPressed: (){

                        context.push(NamedRoutes.forgotpassword);

                        }, child: Text("Forgot password?")),


                    SizedBox(height: 40,),


                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15),
                              backgroundColor: Palette.lightBlueColor,
                              foregroundColor: Palette.blueColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                side: BorderSide(color: Palette.blueColor)

                              )
                          ),
                          onPressed: (){
                            context.push(NamedRoutes.signup);

                          }, child: Text("Create Account")
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
