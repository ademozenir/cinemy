import 'package:cinemy/bloc/auth_cubit.dart';
import 'package:cinemy/locator.dart';
import 'package:cinemy/tmdb/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              BlocBuilder<AuthCubit, User>(
                bloc: getIt.get<AuthCubit>(),
                builder: (_, user) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 25),
                        child: SizedBox(
                          child: CircleAvatar(
                            radius: 70,
                            backgroundImage: NetworkImage(user.photoUrl),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(user.name),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(user.email),
                      ),
                      const SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: SizedBox(
                          width: 160,
                          height: 40,
                          child: ElevatedButton(
                              onPressed: () {},
                              child: const Text(
                                "Edit Profile",
                                style: TextStyle(fontSize: 16),
                              )),
                        ),
                      )
                    ],
                  );
                },
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Divider(color: Colors.grey),
              ),
              Row(
                children: [
                  const SizedBox(width: 30),
                  IconButton(iconSize: 35, onPressed: () {}, icon: const Icon(Icons.settings)),
                  const SizedBox(width: 10),
                  const Text("Settings", style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 100),
                  IconButton(iconSize: 35, onPressed: () {}, icon: const Icon(Icons.keyboard_arrow_right_sharp)),
                  const SizedBox(width: 30),
                ],
              ),
              Row(
                children: [
                  const SizedBox(height: 20, width: 30),
                  IconButton(iconSize: 35, onPressed: () {}, icon: const Icon(Icons.account_balance_wallet_sharp)),
                  const SizedBox(width: 10),
                  const Text("Billing Details", style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 65),
                  IconButton(iconSize: 35, onPressed: () {}, icon: const Icon(Icons.keyboard_arrow_right_sharp)),
                  const SizedBox(width: 30),
                ],
              ),
              Row(
                children: [
                  const SizedBox(height: 20, width: 30),
                  IconButton(iconSize: 35, onPressed: () {}, icon: const Icon(Icons.manage_accounts)),
                  const SizedBox(width: 10),
                  const Text("User Management", style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 30),
                  IconButton(iconSize: 35, onPressed: () {}, icon: const Icon(Icons.keyboard_arrow_right_sharp)),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Divider(color: Colors.grey),
              ),
              Row(
                children: [
                  const SizedBox(width: 35),
                  BlocBuilder<AuthCubit, User>(
                    bloc: getIt.get<AuthCubit>(),
                    builder: (_, user) {
                      return IconButton(
                          iconSize: 35,
                          onPressed: () => getIt.get<AuthCubit>().signOut(),
                          icon: const Icon(Icons.logout));
                    },
                  ),
                  const SizedBox(width: 10),
                  const Text("LogOut", style: TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
