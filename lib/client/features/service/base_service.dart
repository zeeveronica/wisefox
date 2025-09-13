abstract class BaseService {
  Future<dynamic> getResponse(String url);
  Future<dynamic> getResponseDirect(String url, var headers);
  Future<dynamic> postResponse(String url, var body);
  Future<dynamic> putResponse(String url, var body, var headers);
  Future<dynamic> deleteResponse(String url, var headers);

  Future<dynamic> deleteWithBody(String url, var body);
  Future<dynamic> patchResponse(String url, var body, var headers);
}
