abstract class BaseService {
  final String mediaBaseUrl = "https://dummyjson.com/";

  Future<dynamic> getResponse(String url);
  Future<dynamic> postResponse(String url, Map<String, dynamic> body);

}