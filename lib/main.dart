import 'package:challenge/ui/view/login_view.dart';
import 'package:challenge/ui/view/product_detail_view.dart';
import 'package:challenge/ui/view/product_list_view.dart';
import 'package:challenge/ui/view_model/login_view_model.dart';
import 'package:challenge/ui/view_model/product_detail_view_model.dart';
import 'package:challenge/ui/view_model/product_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
        ChangeNotifierProvider.value(value: LoginViewModel()),
        ChangeNotifierProvider.value(value: ProductDetailViewModel()),
        ChangeNotifierProvider.value(value: ProductListViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Media Player',
        theme: ThemeData(
            appBarTheme: const AppBarTheme(),
            primaryColor: const Color(0xFF9E007E),
            primarySwatch: const MaterialColor(0xFF9E007E, {
      50: Color(0xFFF6E3F1),
      100: Color(0xFFE3B8D9),
      200: Color(0xFFD08CAC),
      300: Color(0xFFBC5E7F),
      400: Color(0xFFA82C61),
      500: Color(0xFF9E007E),
      600: Color(0xFF8E006F),
      700: Color(0xFF7D005F),
      800: Color(0xFF6C004F),
      900: Color(0xFF5A003F),
    }),),
        initialRoute: '/product_list',
        routes: {
          '/login': (context) => const LoginScreen(),
          '/product_list': (context) => const ProductListScreen(),
          '/product_detail': (context) => ProductDetailScreen(
                productArgs: (ModalRoute.of(context)!.settings.arguments
                    as ProductDetailViewArgs),
              ),
        },
      ),
    );
  }
}
