
import 'package:appify_lab_socm/res/animation/slide_transition_animation.dart';
import 'package:appify_lab_socm/res/animation/tweens.dart';
import 'package:appify_lab_socm/res/routes/named_routes.dart';
import 'package:appify_lab_socm/views/auth_wrapper/auth_wrapper_screen.dart';
import 'package:appify_lab_socm/views/create_post/create_post_screen.dart';
import 'package:appify_lab_socm/views/forgot_password/forgot_password_screen.dart';
import 'package:appify_lab_socm/views/newsfeed/newsfeed_screen.dart';
import 'package:appify_lab_socm/views/signin/signin_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../views/appify_lab/appify_lab_screen.dart';
import '../../views/signup/signup_screen.dart';

final routes = [
    GoRoute(
        path: NamedRoutes.root,

        builder: (context, state)=>const AppifyLabScreen()
    ),
    GoRoute(
        path: NamedRoutes.signup,
        pageBuilder: (context, state){
            return slideTransition(const SignUpScreen(), rtlTweens());
        },

    ),
    GoRoute(
        path: NamedRoutes.signin,
        pageBuilder: (context, state){
          return slideTransition(const SignInScreen(), rtlTweens());
        },
    ),

    GoRoute(
        path: NamedRoutes.newsfeed,
        pageBuilder: (context, state){
            return slideTransition(const NewsFeedScreen(), rtlTweens());
        },
    ),

    GoRoute(
        path: NamedRoutes.authwrapper,
        pageBuilder: (context, state){
            return slideTransition(const AuthWrapperScreen(), rtlTweens());
        },
    ),

    GoRoute(
        path: NamedRoutes.createpost,
        pageBuilder: (context, state){
            final name = state.extra as String;
            return slideTransition( CreatePostScreen(
                type: name,
            ), utbTweens());
        },
    ),

    GoRoute(
        path: NamedRoutes.forgotpassword,
        pageBuilder: (context, state){
            return slideTransition( ForgotPasswordScreen(), rtlTweens());
        },
    ),

];

