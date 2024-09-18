import 'package:amazon_clone/controller/provider_controller/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatelessWidget {
  static const String routeName = '/home-screen';

  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user.name),
            Text(user.email),
            Text(user.password),
            Text(user.type),
            Text(user.address),
          ],
        ),
      ),
    );
  }
}
