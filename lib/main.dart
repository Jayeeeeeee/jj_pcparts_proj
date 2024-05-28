import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jj_pcparts_proj/firebase_options.dart';
import 'package:jj_pcparts_proj/functions/admin_view.dart';
import 'package:jj_pcparts_proj/functions/order_summary.dart';
import 'package:jj_pcparts_proj/login/adminlogin.dart';
import 'package:jj_pcparts_proj/login/login_page.dart';
import 'package:jj_pcparts_proj/login/register.dart';
import 'package:jj_pcparts_proj/models/shop.dart';
import 'package:jj_pcparts_proj/pages/user/cart.dart';
import 'package:jj_pcparts_proj/pages/user/customer_order.dart';
import 'package:jj_pcparts_proj/pages/user/customerview.dart';
import 'package:jj_pcparts_proj/utils/constants/text_strings.dart';
import 'package:jj_pcparts_proj/utils/theme/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => Shop(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: JJTexts.appName,
      theme: JJAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      //scrollBehavior: MyCustomScrollBehavior(),
      home: const Login(),
      routes: {
        'order_summary': (context) => const OrderSummaryPage(),
        '/customerview': (context) => const CustomerView(),
        '/cart': (context) => const Cart(),
        '/customer_order': (context) => const CustomerOrder(),
        '/register': (context) => const Register(),
        '/login': (context) => const Login(),
        '/adminlogin': (context) => const AdminLogin(),
        '/admin_view': (context) => const ProductData(),
      },
    );
  }
}

// home: const Scaffold(
// backgroundColor: JJColors.primary,
// body: Center(
// child: CircularProgressIndicator(color: JJColors.white),
//  ),
