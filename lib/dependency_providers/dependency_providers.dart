import 'package:appify_lab_socm/repositories/auth_repository.dart';
import 'package:appify_lab_socm/repositories/newsfeed_repository.dart';
import 'package:appify_lab_socm/repositories/profile_repository.dart';
import 'package:appify_lab_socm/res/theme/pallete.dart';
import 'package:appify_lab_socm/views/appify_lab/appify_lab_screen.dart';
import 'package:appify_lab_socm/views/route_error/route_error_screen.dart';
import 'package:appify_lab_socm/views/signup/signup_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../res/common_notifiers/theme_notifier.dart';
import '../res/routes/named_routes.dart';
import '../res/routes/routes.dart';


final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});

final colorPaletteProvider = Provider<Palette>((ref) => Palette());

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final firestoreProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final firebaseStorageProvider = Provider<FirebaseStorage>((ref) => FirebaseStorage.instance);

final authStateChangesProvider = StreamProvider<User?>(
        (ref) {
          return ref.watch(firebaseAuthProvider).authStateChanges();
        }
);

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(firebaseAuth: ref.watch(firebaseAuthProvider), profileRepository: ref.watch(profileRepositoryProvider));
});

final newsfeedRepositoryProvider = Provider<NewsfeedRepository>((ref) {
  return NewsfeedRepository(firebaseAuth: ref.watch(firebaseAuthProvider), firebaseFirestore: ref.watch(firestoreProvider), firebaseStorage: ref.watch(firebaseStorageProvider));
});

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(firebaseAuth: ref.watch(firebaseAuthProvider), firebaseFirestore: ref.watch(firestoreProvider), firebaseStorage: ref.watch(firebaseStorageProvider));
});


/*final myProfileStream = StreamProvider<Object>((ref){
  final profileRepository = ref.watch(profileRepositoryProvider);
  return profileRepository.myProfile();
});*/

final routeProvider = Provider<GoRouter>((ref){

  return GoRouter(
    errorBuilder: (context, state)=>const RouteErrorScreen(),
      initialLocation: NamedRoutes.root,
      routes: routes
  );
});
