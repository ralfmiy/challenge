import 'package:challenge/ui/model/login_model.dart';
import 'package:flutter/material.dart';

import '../view/product_list_view.dart';

class LoginViewModel with ChangeNotifier {


  Future<void> postLogin(LoginModel log, BuildContext context) async {
    
    if (log.username!=null && log.username!.isNotEmpty && log.password!=null && log.password!.isNotEmpty) {
      notifyListeners();
      try {
        await log.postLogin();
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => const ProductListScreen())));
      } catch (e) {
        print(e);
      }
    }

    notifyListeners();
  }
}
