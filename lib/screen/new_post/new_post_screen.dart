import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapp/screen/home/cubit/cubit.dart';
import 'package:socialapp/screen/home/cubit/states.dart';
import 'package:socialapp/styles/icon_broken.dart';
import 'package:socialapp/widget/widget_file.dart';

class NewPostScreen extends StatelessWidget
{
  var textController = TextEditingController();

   @override
 Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialCreatePostSuccessState)
        {
           Fluttertoast.showToast(
                msg: "You Add Post Successfuly ",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 6,
                backgroundColor: Colors.deepPurple,
                textColor: Colors.white,
                fontSize: 16.0);

        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor:Colors.black87 ,
            title:Text("Create Post") ,
            actions: [
              TextButton(
                onPressed: ()
                {
                  var now = DateTime.now();

                  if (SocialCubit.get(context).postImage == null)
                  {
                    SocialCubit.get(context).createPost(
                      dateTime: now.toString(),
                      text: textController.text,
                    );
                  } else
                    {
                      SocialCubit.get(context).uploadPostImage(
                        dateTime: now.toString(),
                        text: textController.text,
                      );
                    }
                },
                child:Text('Post',style:TextStyle(color: Colors.deepPurpleAccent,fontSize: 18),)
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                        '${SocialCubit.get(context).userModel!.image}'
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text(
                        '${SocialCubit.get(context).userModel!.username}',
                        style: TextStyle(
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'what is on your mind ...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                if(SocialCubit.get(context).postImage != null)
                  Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 140.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0,),
                        image: DecorationImage (
                          image: FileImage (SocialCubit.get(context).postImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: CircleAvatar(
                        radius: 20.0,
                        child: Icon(
                          Icons.close,
                          size: 16.0,
                        ),
                      ),
                      onPressed: ()
                      {
                        SocialCubit.get(context).removePostImage();
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: ()
                        {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              IconBroken.Image,color:Colors.deepPurple ,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'add photo',style: TextStyle(color: Colors.deepPurple),
                            ),
                          ],
                        ),
                      ),
                    ),
                   
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
