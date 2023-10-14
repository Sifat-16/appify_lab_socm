import 'package:appify_lab_socm/dependency_providers/dependency_providers.dart';
import 'package:appify_lab_socm/views/newsfeed/newsfeed_screen.dart';
import 'package:appify_lab_socm/views/signin/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthWrapperScreen extends ConsumerWidget {
  const AuthWrapperScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateChangesProvider);
    return user.when(
        data: ((user)=>user == null? const SignInScreen():const NewsFeedScreen()),
        error: ((error,showtrace) => Text(error.toString())),
        loading: ()=> CircularProgressIndicator()
    );
  }
}
