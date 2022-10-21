import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/screen/feeds/feeds_screen.dart';
import 'package:socialapp/screen/home/cubit/cubit.dart';
import 'package:socialapp/screen/home/cubit/states.dart';
import 'package:socialapp/screen/new_post/new_post_screen.dart';
import 'package:socialapp/styles/icon_broken.dart';
import 'package:socialapp/widget/widget_file.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is SocialCreatePostSuccessState)
        {
          SocialCubit.get(context).posts=[];
          SocialCubit.get(context).getPosts();
        }
       
          if (state is SocialNewPostState) {
           
          navigateTo(
            context,
            NewPostScreen(),
          );
        }
      },
     builder: (context, state)
      {  
        return
        Scaffold(
  
          appBar: AppBar(
            backgroundColor: Colors.black87,
            title: Text(
              SocialCubit.get(context).titles[SocialCubit.get(context).currentIndex],
            ),
            actions: [
              IconButton(
                icon: Icon(
                  IconBroken.Notification,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  IconBroken.Search,
                ),
                onPressed: () {},
              ),
            ],
          ),
          body: SocialCubit.get(context).screens[SocialCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.deepPurple,
            unselectedItemColor: Colors.black87,

            //backgroundColor: Colors.red,
            //fixedColor: Colors.black87,
            currentIndex: SocialCubit.get(context).currentIndex,
            onTap: (index)
           
            {
              SocialCubit.get(context).changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                
                icon: Icon(
                  IconBroken.Home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Chat,
                ),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Paper_Upload,
                ),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Location,
                ),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Setting,
                ),
                label: 'Settings',
              ),
            ],
          ),
        );
         
      },
    );
  }
}



        
      
        