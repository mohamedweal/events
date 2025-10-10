import 'package:events/UI/Common/AppNameText.dart';
import 'package:events/UI/Common/CustonFormField.dart';
import 'package:events/UI/Common/Validatos.dart';
import 'package:events/UI/design/design.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                    label: "Text",
                    controller: nameController,
                    icon: Icons.person,
                    keyboardType: TextInputType.name,
                    validator: (text){
                      if(text!.trim().isEmpty == true){
                        return "Please Enter Name";
                      }
                    },
                  ),
                  AppFormField(
                    label: "E-mail",
                    controller: emailController,
                    icon: Icons.mail,
                    keyboardType: TextInputType.emailAddress,
                    validator: (text){
                      if(text!.trim().isEmpty == true){
                        return "Please Enter Email";
                      }
                      if(!isValidEmail(text)){
                        return "Please Enter Valid Email";
                      }
                    },
                  ),
                  AppFormField(
                    label: "Phone",
                    controller: phoneController,
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    validator: (text){
                      if(text!.trim().isEmpty == true){
                        return "Please Enter Phone";
                      }
                      if(!isValidPhone(text)){
                        return "Please Enter Valid Phone";
                      }
                    },
                  ),
                  AppFormField(
                    label: "Password",
                    controller: passwordController,
                    icon: Icons.lock,
                    isPassword: true,
                    keyboardType: TextInputType.text,
                    validator: (text){
                      if(text!.trim().isEmpty == true){
                        return "Please Enter Password";
                      }
                      if((text?.length??0) < 6){
                        return "Password must be at least 6 characters";
                      }
                    },
                  ),
                  AppFormField(
                    label: "Re-Type Password",
                    controller: rePasswordController,
                    icon: Icons.lock,
                    isPassword: true,
                    keyboardType: TextInputType.text,
                    validator: (text){
                      if(text!.trim().isEmpty == true){
                        return "Please Enter Password";
                      }
                      if(passwordController.text != text){
                        return "Password doesn't match";
                      }
                    },
                  ),
                  ElevatedButton(onPressed: (){
                    createAccount();
                  },
                      child: Text('Create Account')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool validateForm(){
    return formKey.currentState!.validate() ?? false;
  }

  void createAccount() {
    if(validateForm() == false){
      return;
    }
  }
}
