import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/model/userd_data.dart';
import 'package:socialapp/screen/login/cubit/states.dart';
import 'package:socialapp/widget/widget_file.dart';



class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  })
  {
    emit(SocialLoginLoadingState());

    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
    .then((value) {
     // uId=value.user!.uid;
     // iHaveuId=true;
      print(uId);
      print("---------success-----------");
      print(value.user!.email);
      emit(SocialLoginSuccessState(value.user!.uid));

    })
    .catchError((error){
      print("-------------error------------");
      emit(SocialLoginErrorState(error.toString()));


    });
  }

  

IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    print("abo room");
    isPassword = !isPassword;
    suffix = !isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(SocialChangePasswordVisibilityState());
  }
}