import 'package:challenge/model/api/api_response.dart';
import 'package:challenge/model/login_model.dart';
import 'package:challenge/view/screens/product_list_screen.dart';
import 'package:flutter/material.dart';

class LoginViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');

  ApiResponse get response {
    return _apiResponse;
  }

  Future<void> postLogin(LoginModel log, BuildContext context) async {
    _apiResponse = ApiResponse.loading('Ingresando');
    if (log.username!=null && log.username!.isNotEmpty && log.password!=null && log.password!.isNotEmpty) {
      notifyListeners();
      try {
        LoginModel login = await log.postLogin();
        _apiResponse = ApiResponse.completed(login);
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => ProductListScreen())));
      } catch (e) {
        _apiResponse = ApiResponse.error(e.toString());
        print(e);
      }
    }

    notifyListeners();
  }
}
