import 'package:appify_lab_socm/view_models/forgot_password_provider/forgot_password_generic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../res/theme/pallete.dart';
import '../../utils/common_widgets/validation_text_field.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final forgotProvider = ref.watch(forgotPasswordProvider);
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
                            textEditingController: forgotProvider.emailController,
                            validateFunction: (s){
                              ref.read(forgotPasswordProvider.notifier).checkIsEmail();
                            },
                            validate: forgotProvider.isEmail
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
                            ref.read(forgotPasswordProvider.notifier).verifyMail(context,
                                forgotProvider.emailController.text.trim(),
                                forgotProvider.isEmail
                            );
                          }, child: forgotProvider.loading?Center(child: CircularProgressIndicator(color: Colors.white,),): Text("Send Mail")
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
