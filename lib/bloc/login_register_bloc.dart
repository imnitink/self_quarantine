
import 'package:rxdart/rxdart.dart';

import '../service/api_provider.dart';

class LoginRegisterBloc {

  final _loginFetcher = PublishSubject<dynamic>();
  Observable<dynamic> get getLoginStream => _loginFetcher.stream;
  bool loading = false;
  bool loginState = true;
  bool pinState = false;
  bool registerState = false;

  bool passport = true;

 Future<bool> login(Map body) async{

    loading = true;
    dynamic response = await ApiProvider.login(body);
    dynamic data = handleExeceptionsError(response);
    loading = false;
    if(data != null){
      loginState = true;
      pinState = true;
      _loginFetcher.sink.add(null);
    }

    return data !=null;
  }

  Future<bool> register(Map body) async{

    loading = true;
    dynamic response = await ApiProvider.register(body);
    dynamic data = handleExeceptionsError(response);
    loading = false;
    return data !=null;
  }
  
  Future<bool> reSendSmsForUser(Map body) async{

    loading = true;
    dynamic response = await ApiProvider.resendsmsforuser(body);
    dynamic data = handleExeceptionsError(response);
    loading = false;
    return data !=null;
  }

  Future<bool> updateUserSmsVerified(Map body) async{

    loading = true;
    dynamic response = await ApiProvider.updateusersmsverified(body);
    dynamic data = handleExeceptionsError(response);
    loading = false;
    return data !=null;
  }

  enableRegisterState (){
   loginState = false;
   registerState = true;
   _loginFetcher.sink.add(null);

  }

  enableLoginState (){
    loginState = true;
    registerState = false;
    _loginFetcher.sink.add(null);

  }

  enableLoginFromPinState (){
    pinState = false;
    loginState = true;
    _loginFetcher.sink.add(null);

  }

  togglePassEmirates(){
    passport = !passport;
    _loginFetcher.sink.add(null);
  }
  dispose() {
    _loginFetcher.close();
  }


   dynamic handleExeceptionsError(dynamic response) {
    if(response != null){
      if(response is Map<String,dynamic>){
              return response;
      }else if(response is Exception){
        return null;

      }else{
        return null;
      }
    }
    return null;
  }
}