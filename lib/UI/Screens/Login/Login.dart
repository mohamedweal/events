import 'package:events/UI/Common/AppNameText.dart';
import 'package:events/UI/Common/CustonFormField.dart';
import 'package:events/UI/Provider/AppAuthProvider.dart';
import 'package:events/UI/design/design.dart';
import 'package:events/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:events/UI/Common/Validatos.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();


  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 24,
              horizontal: 16),
          child: Column(
            children: [
              Image.asset(AppImages.appIcon),
              AppNameText(),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppFormField(
                        controller: emailController,
                        label: "E-mail",
                        icon: Icons.mail,
                        keyboardType: TextInputType.emailAddress,
                        validator: (text) {
                          if(text?.trim().isEmpty == true){
                            return "Please enter email";
                          }
                          if(!isValidEmail(text)){
                            return "Please enter valid email";
                          }
                        }
                    ),

                    AppFormField(
                      controller: passwordController,
                      label: "Password",
                      icon: Icons.lock,
                      isPassword: true,
                      keyboardType: TextInputType.text,
                      validator: (text) {
                        if(text?.trim().isEmpty == true){
                          return "please enter password";
                        }
                        if((text?.length??0) < 6){
                          return "Password must be at least 6 characters";
                        }
                      },
                    ),
                    ElevatedButton(onPressed: isLoading ? null: (){
                      login();
                    },
                        child: isLoading? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(width: 12,),
                            Text("logging you in")
                          ],
                        ):
                        Text("Sign in")),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't Have Account ? ",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.black
                          ),),
                        TextButton(onPressed: (){
                          Navigator.pushReplacementNamed(context, AppRoutes.RegisterScreen.name);
                        },
                            child: Text("Create Account")
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }

  void login()async {
    if(validateForm() == false){
      return;
    }
    setState(() {
      isLoading = true;
    });
    AppAuthProvider provider = Provider.of<AppAuthProvider>(context, listen: false);
    AuthResponse response = await provider.login(
        emailController.text,
        passwordController.text);
    if(response.success){
      // successfully created account
      // show dialog of success
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("logged in successfully"),));
      Navigator.pushReplacementNamed(context, AppRoutes.HomeScreen.name);

    }else {
      // has error
      handleAuthError(response);
    }
    setState(() {
      isLoading = false;
    });
  }

  bool validateForm(){
    return formKey.currentState?.validate() ?? false;
  }

  void handleAuthError(AuthResponse response) {
    String errorMessage;

    switch(response.failure){
      case AuthFailure.invalidCredentials:
        errorMessage = "Wrong Email or password";
        break;
      default:
        errorMessage = "something went wrong";
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage),));

  }
}