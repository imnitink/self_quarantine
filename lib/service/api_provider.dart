import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiProvider{

  static final baseUrl = "http://appdev.cerebrum.ae/covidapi/quarantine";
  static final _register = "/register";
  static final _login = "/login";
  static final _resendsmsforuser = "/resendsmsforuser";
  static final _updateusersmsverified = "/updateusersmsverified";

  static Future<dynamic>  httpPost(Map<dynamic,dynamic> bodyData,String apiName) async{



    Map<String,String> header = Map();
    header.putIfAbsent("content-type", () => "application/json");

    var body = json.encode(bodyData);
   String url = baseUrl+apiName;
    print("API Header : "+ url+" "+header.toString());
    print("API Requests : "+ url+" "+body);
    try {
      final response = await http.post(url, headers: header ,body: body).timeout(const Duration(seconds: 30)).then((result) {

        print("API Response : "+url+" "+result.body);
        if (result.statusCode == 200) {
          print("Api success");
          Map<String,dynamic> responseMap = jsonDecode(result.body);
          return responseMap;
        } else {
          print("Api failed");

          return null;
        }
      }).catchError((onError){

        print(onError.toString());
        return onError;
      });
      return response;
    } catch (e) {
      print(e);
      return e;
    }


  }

  static Future<dynamic> register(Map body) async{
    dynamic response = await httpPost(body, _register);
    return response;

  }

  static Future<dynamic> login(Map body) async{
    dynamic response = await httpPost(body, _login);
    return response;
  }

  static Future<dynamic> resendsmsforuser(Map body) async{
    dynamic response = await httpPost(body, _resendsmsforuser);
    return response;
  }

  static Future<dynamic> updateusersmsverified (Map body) async{
    dynamic response = await httpPost(body, _updateusersmsverified );
    return response;
  }
}