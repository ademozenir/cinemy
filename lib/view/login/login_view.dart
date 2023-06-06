import 'package:cinemy/bloc/auth_cubit.dart';
import 'package:cinemy/locator.dart';
import 'package:cinemy/view/widget/button.dart';
import 'package:cinemy/view/widget/square_tile.dart';
import 'package:cinemy/view/widget/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 35),
                SvgPicture.asset(width: 120, height: 120, "assets/images/tmdb.svg"),
                const SizedBox(height: 40),
                Text('Welcome back you\'ve been missed!', style: TextStyle(color: Colors.grey[700], fontSize: 16)),
                const SizedBox(height: 25),
                CreateTextField(controller: usernameController, hintText: 'Username', obscureText: false),
                const SizedBox(height: 15),
                CreateTextField(controller: passwordController, hintText: 'Password', obscureText: true),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Text('Forgot Password?', style: TextStyle(color: Colors.grey[600]))],
                  ),
                ),
                const SizedBox(height: 20),
                CreateButton(
                  onTap: signUserIn,
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(
                      imagePath: 'assets/icons/google.png',
                      onTap: () => getIt.get<AuthCubit>().signInWithGoogle(),
                    ),
                    const SizedBox(width: 25),
                    SquareTile(
                      imagePath: 'assets/icons/apple.png',
                      onTap: () {},
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Register now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
