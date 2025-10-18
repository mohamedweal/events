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
              // Assuming AppImages.appIcon is defined in 'design.dart'
              // Image.asset(AppImages.appIcon),
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
                          // FIX: Use '!' to assert non-null because we've already checked for empty/null
                          // This resolves the type mismatch if isValidEmail expects a non-nullable String.
                          if(!isValidEmail(text!)){
                            return "Please enter valid email";
                          }
                          return null; // Must return null on success
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
                        return null; // Must return null on success
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
    // These types (AppAuthProvider, AuthResponse, AuthFailure) must be defined and imported elsewhere.
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
      case AuthFailure.userDisabled: // NEW
        errorMessage = "Your account has been disabled.";
        break;
      case AuthFailure.tooManyRequests: // NEW
        errorMessage = "Too many failed attempts. Try again later.";
        break;
      case AuthFailure.networkError: // NEW
        errorMessage = "Network error. Check your connection.";
        break;
      default:
        errorMessage = "something went wrong"; // This should now only happen for truly unhandled errors
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage),));
  }
}