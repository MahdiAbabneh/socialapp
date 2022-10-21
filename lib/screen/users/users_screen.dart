import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/screen/home/cubit/cubit.dart';
import 'package:socialapp/screen/home/cubit/states.dart';

class UsersScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold();
      },
    );
  }}