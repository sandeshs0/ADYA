import 'package:flutter/material.dart';
import 'view/login_page.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  static const Color textColor = Color.fromRGBO(223, 246, 255, 100);
  static const Color bgColor = Color.fromRGBO(6, 40, 61, 100);
  static const Color btnColor = Color.fromRGBO(71, 181, 255, 100);
  static const Color logoColor = Color.fromRGBO(37, 109, 133, 100);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(
        onTap: () {},
      ),
      // routes: {
      //   '/statistics': (context) => StatisticPage(),
      //   '/transaction': (context) => TransactionPage(),
      //   '/receipt': (context) => ReceiptPage(),
      // },
);

  }
}