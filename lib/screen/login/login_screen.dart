import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapp/screen/home/home_screen.dart';
import 'package:socialapp/screen/login/cubit/cubit.dart';
import 'package:socialapp/screen/login/cubit/states.dart';
import 'package:socialapp/screen/register/shop_register_screen.dart';
import 'package:socialapp/widget/widget_file.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      var formKey = GlobalKey<FormState>();
      var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
           if(state is SocialLoginSuccessState)
          {
             uId=FirebaseAuth.instance.currentUser!.uid;
             
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) {
                return HomeScreen();
              }));
                Fluttertoast.showToast(
                msg: "You Login Successfuly",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.deepPurple,
                textColor: Colors.white,
                fontSize: 16.0);
            
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                                color: Colors.black,
                              ),
                        ),
                        Text(
                          'Login now to chat ^-^',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'please enter your email address';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField2(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: SocialLoginCubit.get(context).suffix,
                          onSubmit: (value) {
                            
                            if (formKey.currentState!.validate()) {
                              SocialLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );}
                               

                            
                          },
                          isPassword: SocialLoginCubit.get(context).isPassword,
                          suffixPressed: () {
                            SocialLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'password is too short';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                          condition: state is! SocialLoginCubit,
                          builder: (context) => defaultButton(
                            function: () {
                              
                              if (formKey.currentState!.validate()) {
                                SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                 
                              }
                             
                            },
                            text: 'login',
                            isUpperCase: true,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                            ),
                            TextButton(
                              
                              onPressed: () {
                                navigateTo(context, ShopRegisterScreen());
                              },
                              child: Text('Register',style: TextStyle(color: Colors.blueGrey,fontSize: 20),),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }); }
}

/*

*/
