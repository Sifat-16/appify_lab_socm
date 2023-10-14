
import 'package:appify_lab_socm/dependency_providers/dependency_providers.dart';
import 'package:appify_lab_socm/res/routes/named_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AppifyLabScreen extends ConsumerStatefulWidget {
  const AppifyLabScreen({super.key});
  @override
  ConsumerState<AppifyLabScreen> createState() => _AppifyLabScreenState();
}

class _AppifyLabScreenState extends ConsumerState<AppifyLabScreen> {

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 2), ()async{

        final firebaseAuth = ref.watch(firebaseAuthProvider);

        if(firebaseAuth.currentUser==null){
          context.go(NamedRoutes.signin);
        }else{
          context.go(NamedRoutes.newsfeed);
        }

      });
    });
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/appify_lab_icon.png", width: 60, height: 60,),
      ),
    );
  }
}
