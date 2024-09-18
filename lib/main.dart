import 'package:amazon_clone/View/auth/authScreen.dart';
import 'package:amazon_clone/View/homeScreen.dart';
import 'package:amazon_clone/constant/global.dart';
import 'package:amazon_clone/controller/authcontroller.dart';
import 'package:amazon_clone/controller/provider_controller/user_provider.dart';
import 'package:amazon_clone/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthController authcontroller = AuthController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authcontroller.fetchUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        onGenerateRoute: (settings) => generateRoute(settings),
        debugShowCheckedModeBanner: false,
        title: 'TeleCalling App',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
              color: Colors.orange,
            ),
            colorScheme:
                ColorScheme.light(primary: GlobalVariables.primaryColor)),
        home: Provider.of<UserProvider>(context).user.stamp.isNotEmpty
            ? Homescreen()
            : AuthScreen());
  }
}

// import 'package:amazon_clone/View/auth/authScreen.dart';
// import 'package:amazon_clone/constant/global.dart';
// import 'package:amazon_clone/router.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// void main() {
//   runApp(MultiProvider(providers: [], child: const MyApp()));
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   Future<bool> _onWillPop() async {
//     // Add any logic here to determine if back navigation should proceed
//     return true;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         onGenerateRoute: (settings) => generateRoute(settings),
//         debugShowCheckedModeBanner: false,
//         title: 'Amazon Clone',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//           scaffoldBackgroundColor: Colors.white,
//           useMaterial3: true,
//           appBarTheme: const AppBarTheme(
//             color: Colors.orange,
//           ),
//           colorScheme: ColorScheme.light(primary: GlobalVariables.primaryColor),
//         ),
//         home: WillPopScope(
//             onWillPop: _onWillPop,
//             child: Scaffold(
//               appBar: AppBar(
//                 elevation: 0.0,
//                 title: const Text("Amazon"),
//                 centerTitle: true,
//               ),
//               body: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text("Hello Amazon"),
//                     Builder(builder: (context) {
//                       return ElevatedButton(
//                         onPressed: () {
//                           Navigator.pushNamed(context, AuthScreen.routeName);
//                         },
//                         child: const Text("Click Me"),
//                       );
//                     }),
//                   ],
//                 ),
//               ),
//             )));
//   }
// }
