import 'package:events/UI/Common/AppNameText.dart';
import 'package:events/UI/Common/CustonFormField.dart';
import 'package:events/UI/Provider/AppAuthProvider.dart';
import 'package:events/UI/design/design.dart';
import 'package:events/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:events/UI/Common/Validatos.dart'; // Import is correct now

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController retypePasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 24,
              horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Assuming AppImages.appIcon is defined
                // Image.asset(AppImages.appIcon),
                AppNameText(),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppFormField(
                        controller: nameController,
                        label: "Name",
                        icon: Icons.person,
                        keyboardType: TextInputType.name,
                        validator: (text) {
                          if(text?.trim().isEmpty == true){
                            return "Please enter Name";
                          }
                          return null; // Must return null on success
                        },
                      ),
                      AppFormField(
                          controller: emailController,
                          label: "E-mail",
                          icon: Icons.mail,
                          keyboardType: TextInputType.emailAddress,
                          validator: (text) {
                            if(text?.trim().isEmpty == true){
                              return "Please enter email";
                            }
                            // FIX: Use '!' to assert non-null after checking for empty/null
                            if(!isValidEmail(text!)){
                              return "Please enter valid email";
                            }
                            return null; // Must return null on success
                          }
                      ),
                      AppFormField(
                          controller: phoneController,
                          label: "phone",
                          icon: Icons.phone,
                          keyboardType: TextInputType.phone,
                          validator: (text) {
                            if(text?.trim().isEmpty == true){
                              return "Please enter phone";
                            }
                            // FIX: Use '!' to assert non-null after checking for empty/null
                            if(!isValidPhone(text!)){
                              return "Please enter valid phone";
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
                      AppFormField(
                        controller: retypePasswordController,
                        label: "Re-type Password",
                        icon: Icons.lock,
                        isPassword: true,
                        keyboardType: TextInputType.text,
                        validator: (text) {
                          if(text?.trim().isEmpty == true){
                            return "please enter password";
                          }
                          if(passwordController.text != text){
                            return "Password does not match";
                          }
                          return null; // Must return null on success
                        },
                      ),
                      ElevatedButton(onPressed: isLoading ? null: (){
                        createAccount();
                      },
                          child: isLoading? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(width: 12,),
                              Text("Creating account")
                            ],
                          ):
                          Text("Create Account")),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already Have Account ? ",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.black
                            ),),
                          TextButton(onPressed: (){
                            Navigator.pushReplacementNamed(context, AppRoutes.LoginScreen.name);
                          },
                              child: Text("Login")
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

  void createAccount()async {
    if(validateForm() == false){
      return;
    }
    setState(() {
      isLoading = true;
    });
    // This assumes AppAuthProvider, AuthResponse, and AppRoutes are defined.
    AppAuthProvider provider = Provider.of<AppAuthProvider>(context, listen: false);
    AuthResponse response = await provider.register(emailController.text,
        passwordController.text,
        nameController.text, phoneController.text);
    if(response.success){
      // successfully created account
      // show dialog of success
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User Registered successfully"),));
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

    // This assumes AuthFailure enum is defined.
    switch(response.failure){
      case AuthFailure.weakPassword:
        errorMessage = "Weak password";
        break;
      case AuthFailure.emailAlreadyUsed:
        errorMessage = "Email already used";
        break;
      default:
        errorMessage = "something went wrong";
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage),));

  }

}