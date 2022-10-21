import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/model/userd_data.dart';
import 'package:socialapp/screen/register/cubit/states.dart';
import 'package:socialapp/widget/widget_file.dart';


class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  })
  {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
    .then((value) {
      print(value.user!.email);
       print(value.user!.uid);

       userCreate(
         name: name,
         email: email,
         phone: phone,
         uId: value.user!.uid);
    })
    .catchError((error){
      emit(SocialRegisterErrorState(error.toString()));
    });
  }
   SocialUserModel? model;

  void userCreate(
    {
    required String name,
    required String email,
    required String phone,
    required String uId,    }
  )
  {

    SocialUserModel model=SocialUserModel(
      uId: uId,
      username:name,
      email: email,
      image:"https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg", 
      bio: 'add your bio',
      cover: 'https://static.vecteezy.com/system/resources/thumbnails/004/639/751/small/default-picture-photo-icon-illustration-isolated-on-white-background-vector.jpg' );
    FirebaseFirestore.instance.collection("users").doc(uId)
    .set(
      model.toMap()
      )
      .then((value) 
      {
        emit(SocialCreateUserSuccessState());
      })
      .catchError((error)
      {
        emit(SocialCreateUserErrorState(error.toString()));
      });
  }



  

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(SocialRegisterChangePasswordVisibilityState());
  }
}
