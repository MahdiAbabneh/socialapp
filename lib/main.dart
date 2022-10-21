import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/bloc_observer.dart';
import 'package:socialapp/screen/home/cubit/cubit.dart';
import 'package:socialapp/screen/home/cubit/states.dart';
import 'package:socialapp/screen/login/cubit/cubit.dart';
import 'package:socialapp/screen/login/cubit/states.dart';
import 'package:socialapp/screen/login/login_screen.dart';
import 'package:socialapp/widget/widget_file.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();
   
  print(uId);
 

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)
  {
    
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => SocialLoginCubit()
        ),
        BlocProvider(
          create: (BuildContext context) => SocialCubit()..getUserData()..getPosts()..getUsers()
        ),
      ],
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
        },
        builder: (context, state) {
          return MaterialApp(
            
            
            
            home: LoginScreen(),
            
          );
        },
      ),
    );
  }
}
