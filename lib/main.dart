import 'package:challenge/view/screens/login_screen.dart';
import 'package:challenge/view/screens/product_detail_screen.dart';
import 'package:challenge/view/screens/product_list_screen.dart';
import 'package:challenge/view_model/login_view_model.dart';
import 'package:challenge/view_model/media_view_model.dart';
import 'package:challenge/view_model/product_detail_view_model.dart';
import 'package:challenge/view_model/product_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'view/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: MediaViewModel()),
        ChangeNotifierProvider.value(value: LoginViewModel()),
        ChangeNotifierProvider.value(value: ProductDetailViewModel()),
        ChangeNotifierProvider.value(value: ProductListViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Media Player',
        theme: ThemeData(
          appBarTheme: AppBarTheme(),
          primaryColor: Colors.purple,
          primarySwatch: Colors.purple,
        ),
        initialRoute: '/product_list',
        routes: {
          '/login': (context) => LoginScreen(),
          '/product_list': (context) => ProductListScreen(),
          '/product_detail': (context) => ProductDetailScreen(),
        },
      ),
    );
  }
}
