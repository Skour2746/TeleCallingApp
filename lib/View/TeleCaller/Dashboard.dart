import 'package:flutter/material.dart';

class TeleCallerDashboard extends StatelessWidget {
  const TeleCallerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(50))),
            child: Column(
              children: [
                const SizedBox(height: 50),
                ListTile(
                  title: Text('Hi Ahad!',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.white)),
                  subtitle: Text(
                    'Good Morning',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.white54),
                  ),
                
                trailing: CircleAvatar(radius: 30,
                backgroundImage: ,),)
              ],
            ),
          )
        ],
      ),
    );
  }
}
