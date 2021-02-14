import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../bloc/login_register_bloc.dart';

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }

}

class LoginState extends State<Login>{

  bool snackBarShowing = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final _loginKey = GlobalKey<FormState>();
  final _fnKey = GlobalKey<FormState>();
  final _regMobileKey = GlobalKey<FormState>();
  final _passportKey = GlobalKey<FormState>();
  final _otpKey = GlobalKey<FormState>();

  final mobileTextCtrl = TextEditingController();
  final pinTextCtrl = TextEditingController();

  final fnTextCtrl = TextEditingController();
  final regMobileTextCtrl = TextEditingController();
  final emiratesPassTextCtrl = TextEditingController();


  LoginRegisterBloc bloc = LoginRegisterBloc();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(onWillPop: () async{

      if(bloc.registerState){
        bloc.enableLoginState();
        return false;
      }

      if(bloc.pinState){
        bloc.enableLoginFromPinState();

        return false;
      }
      return true;
    }, child: GestureDetector(
      onTap: (){
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: null,
          body: Center(
            child: SingleChildScrollView(
              child: Card( elevation: 0, margin: EdgeInsets.all(20),
                  color: Color.fromRGBO(20, 26, 62, 1), child:Padding(
                  padding:EdgeInsets.fromLTRB(30,30,30,30),
                    child: Column(
                mainAxisSize: MainAxisSize.min,
              children: [
              SizedBox( width:50, height: 50,child: Image.asset("assets/icons/ic_applogo.png")),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: Text("SELF-QUARANTINE", style: TextStyle(color:  Colors.white,fontSize: 15, fontWeight: FontWeight.bold),)),
                    StreamBuilder(stream:bloc.getLoginStream,
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          return  bloc.loginState?getLoginScreen():getRegisterWidget() ;
                        })

              ],
              ),
                  )),
            ),
          ),

        ),
      ),
    ),);
  }

  Widget getLoginScreen(){
    bool isError = false;
    bool isButtonPressed = false;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Form(
          onChanged: (){
            isButtonPressed = false;
            if (isError) {
              _loginKey.currentState.validate();
              isError = false;
            }
            print("");
          },
          key: _loginKey,
          child: TextFormField(
            keyboardType: TextInputType.phone,
            style: TextStyle(color: Colors.white),
            controller: mobileTextCtrl,
            validator: (value) {
              if (!isButtonPressed) {
                return null;
              }
              isError = true;
              value = value.trim();
              if (value.isEmpty) {
                return 'Enter Mobile No.';
              }
              isError = false;



              return null;
            },
            decoration: InputDecoration(
              suffixIconConstraints: BoxConstraints(maxHeight: 32,maxWidth: 30),
              suffixIcon: Icon(Icons.phone_iphone, color: Colors.white, size: 22,),
              isDense: true,
              hintText: 'Mobile No.',
              hintStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color:  Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color:  Colors.white),
              ),
            ),
          ),
        ),

           if(bloc.pinState) Padding(
             padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
               child: Text("Enter OTP",style: TextStyle(color:  Colors.white,fontSize: 20,fontWeight: FontWeight.bold))),
        if(bloc.pinState) Text("Enter your 5-digit OTP",style: TextStyle(color:  Colors.white,fontSize: 12)),

        if(bloc.pinState) Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 30),
          child: SizedBox(
            width: 150,
            child: Form(
              onChanged: (){
                isButtonPressed = false;
                if (isError) {
                  _otpKey.currentState.validate();
                  isError = false;
                }
                print("");
              },
              key: _otpKey,
              child: TextFormField(
                controller: pinTextCtrl,
                style: TextStyle(color: Colors.white,fontSize: 16),
                validator: (value) {
                  if (!isButtonPressed) {
                    return null;
                  }
                  isError = true;
                  value = value.trim();
                  if (value.isEmpty) {
                    return 'Enter OTP';
                  }
                  isError = false;



                  return null;
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(5),
                ],
                decoration: InputDecoration(
                  isDense: true,
                  hintText: ' ',
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:  Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color:  Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),

        if(bloc.pinState) GestureDetector( onTap:() async{
          Map params = Map();
          params.putIfAbsent("mobilenumber", () => mobileTextCtrl.text.trim());
          params.putIfAbsent("languageid", () =>1033);
          params.putIfAbsent("mobileapplicationid" , () => 69);
          params.putIfAbsent("regionuid", () =>"5e96e38885871511baebd7a3");
          params.putIfAbsent("businessunituid", () =>"5e945b58f30c55d22c9a7051");
          params.putIfAbsent("tenantuid", () =>"5e94733af30c55d22c9b23bc");
          params.putIfAbsent("assetid", () =>"4b1b11f3-92de-4a62-aaaa-272da7829535");
          params.putIfAbsent("useruid", () =>"5e96ee08ef803s7f4b5e7684");
        bool res = await  bloc.reSendSmsForUser(params);
        if(!res){
          showSnackBarMessage("Sorry something went wrong try after sometime");
        }

        },child: Text("Didn't get a code? Resend code" ,style: TextStyle(color:  Colors.white,fontSize: 15),)),

        Padding(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
          child: RaisedButton(onPressed: () async{
            isButtonPressed = true;
          // bloc.pinState? _otpKey.currentState.validate():_loginKey.currentState.validate() ;

            if(!_loginKey.currentState.validate()){

              return;
            }
            if(bloc.pinState){
              if(!_otpKey.currentState.validate()){
                return;
              }
            }

            if(bloc.pinState){
              Map paramspin = Map();
              paramspin.putIfAbsent("mobilenumber", () => mobileTextCtrl.text.trim());
              paramspin.putIfAbsent("languageid", () =>1033);
              paramspin.putIfAbsent("mobileapplicationid" , () => 69);
              paramspin.putIfAbsent("regionuid", () =>"5e96e38885871511baebd7a3");
              paramspin.putIfAbsent("businessunituid", () =>"5e945b58f30c55d22c9a7051");
              paramspin.putIfAbsent("tenantuid", () =>"5e94733af30c55d22c9b23bc");
              paramspin.putIfAbsent("assetid", () =>"4b1b11f3-92de-4a62-aaaa-272da7829535");
              paramspin.putIfAbsent("useruid", () =>"5e96ee08ef803s7f4b5e7684");
           bool res = await   bloc.updateUserSmsVerified(paramspin);
           if(res){
             Route route = MaterialPageRoute(builder: (context) => Home());
             Navigator.of(context).push(route);
           }else{
             showSnackBarMessage("Sorry something went wrong try after sometime");
           }
            }else{
              Map params = Map();
              params.putIfAbsent("mobilenumber", () => mobileTextCtrl.text.trim());
              params.putIfAbsent("languageid", () =>1033);
              params.putIfAbsent("mobileapplicationid" , () => 69);
              params.putIfAbsent("mobileostype", () =>1);
              params.putIfAbsent("autologin",  () =>false);
              bool res = await   bloc.login(params);
              if(!res){
                showSnackBarMessage("Sorry something went wrong try after sometime");
              }
            }




          },child:   Text( bloc.pinState?"Submit":"Login"),),
        ),
       if(!bloc.pinState) GestureDetector( onTap:(){
         bloc.enableRegisterState();

        },child: Text("Don't have an account? Register",style: TextStyle(color:  Colors.white,fontSize: 15),)),
         ],
    );


  }


  Widget getRegisterWidget(){
    bool isError = false;
    bool isButtonPressed = false;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Form(
          onChanged: (){
            isButtonPressed = false;
            if (isError) {
              _fnKey.currentState.validate();
              isError = false;
            }
            print("");
          },
          key: _fnKey,
          child: TextFormField(
            style: TextStyle(color: Colors.white),
controller: fnTextCtrl,
            validator: (value) {
              if (!isButtonPressed) {
                return null;
              }
              isError = true;
              value = value.trim();
              if (value.isEmpty) {
                return 'Enter Full Name';
              }
              isError = false;
              return null;
            },
            decoration: InputDecoration(
              suffixIconConstraints: BoxConstraints(maxHeight: 32,maxWidth: 30),
              suffixIcon:  Icon(Icons.person, color: Colors.white, size: 22,),
              isDense: true,
              hintText: 'Full Name',
              hintStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color:  Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color:  Colors.white),
              ),
            ),
          ),
        ),


        Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: Form(
            onChanged: (){
              isButtonPressed = false;
              if (isError) {
                _regMobileKey.currentState.validate();
                isError = false;
              }
              print("");
            },
            key: _regMobileKey,
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              controller: regMobileTextCtrl,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (!isButtonPressed) {
                  return null;
                }
                isError = true;
                value = value.trim();
                if (value.isEmpty) {
                  return 'Enter Mobile No.';
                }
                isError = false;

                return null;
              },
              decoration: InputDecoration(
                suffixIconConstraints: BoxConstraints(maxHeight: 32,maxWidth: 30),
                suffixIcon:  Icon(Icons.phone_iphone, color: Colors.white, size: 22,),
                isDense: true,
                hintText: 'Mobile No.',
                hintStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color:  Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color:  Colors.white),
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
          
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue,
              ),
              borderRadius: BorderRadius.all(Radius.circular(30))
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
GestureDetector(
  onTap:(){
    emiratesPassTextCtrl.text = "";
    bloc.togglePassEmirates();
    },
  child:   Container(
  margin: EdgeInsets.zero,
    padding:  EdgeInsets.fromLTRB(20,10,20,10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      color:bloc.passport?Colors.transparent: Colors.blue
    ),

    child: Text(
      "Emirates ID", style: TextStyle(color: Colors.white),
    ),
  ),
),
              GestureDetector(
                onTap:(){
                  emiratesPassTextCtrl.text = "";
                  bloc.togglePassEmirates();
                },
                child: Container(
                  margin: EdgeInsets.zero,
                  padding:  EdgeInsets.fromLTRB(20,10,20,10),

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color:bloc.passport?Colors.blue: Colors.transparent
                  ),
                  child: Text(
                      "Passport No.", style: TextStyle(color: Colors.white),
                  ),
                ),
              )

            ],
          ),
        ),

        Form(
          onChanged: (){
            isButtonPressed = false;
            if (isError) {
              _passportKey.currentState.validate();
              isError = false;
            }
            print("");
          },
          key: _passportKey,

          child: TextFormField(
            style: TextStyle(color: Colors.white),
            controller: emiratesPassTextCtrl,
            validator: (value) {
              if (!isButtonPressed) {
                return null;
              }
              isError = true;
              value = value.trim();
              if (value.isEmpty) {
                return bloc.passport?"Enter Passport No.":'Enter Emirates ID';
              }
              isError = false;

              return null;
            },
            decoration: InputDecoration(
              suffixIconConstraints: BoxConstraints(maxHeight: 32,maxWidth: 30),
              suffixIcon:    SizedBox( width:24, height: 24,child: Image.asset("assets/icons/ic_emirates.png", color: Colors.white,)),
              isDense: true,
              hintText: bloc.passport?"Passport No.":'Emirates ID',
              hintStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color:  Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color:  Colors.white),
              ),
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
          child: RaisedButton(onPressed: () async{
            isButtonPressed = true;
            if(!_fnKey.currentState.validate()){

              return;
            }
            if(!_regMobileKey.currentState.validate()){
              return;
            }
            if(!_passportKey.currentState.validate()){
              return;
            }

            Map params = Map();
            params.putIfAbsent("name", () => fnTextCtrl.text.trim());
            params.putIfAbsent("emiratesid", () =>bloc.passport?"":emiratesPassTextCtrl.text.trim());
            params.putIfAbsent("passportnumber" , () => bloc.passport?emiratesPassTextCtrl.text.trim():"");
            params.putIfAbsent("mobilenumber", () =>mobileTextCtrl.text.trim());
            params.putIfAbsent("emailid", () =>"demo@aa.ae");
            params.putIfAbsent("dateofbirth", () =>1586775847000);
            params.putIfAbsent("languageid", () =>1033);
            params.putIfAbsent("mobileapplicationid", () =>69);
            params.putIfAbsent("mobileostype", () =>1);
           bool res = await bloc.register(params);
           if(res){
             bloc.enableLoginState();
           }else{
             showSnackBarMessage("Sorry something went wrong try after sometime");
           }

          },child:   Text("Register"),),
        ),
        GestureDetector( onTap:(){
          bloc.enableLoginState();

        },child: Text("Already have an account? Log In",style: TextStyle(color:  Colors.white,fontSize: 15),)),

      ],
    );

  }

  showSnackBarMessage(String message){
    if(snackBarShowing){
      return;
    }

    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    )).closed.then((reason) {
      snackBarShowing = false;
      // snackbar is now closed
    });
    snackBarShowing = true;
  }

}


class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }

}

class HomeState extends State<Home>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Color.fromRGBO(20, 26, 62, 1),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: SizedBox( width:50, height: 50,child: Image.asset("assets/icons/ic_applogo.png"))),
          ],
        ),
      ),

    );
  }


}