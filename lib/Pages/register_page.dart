import 'package:flutter/material.dart';
import 'package:utility/services/auth/auth_service.dart';
import 'package:utility/components/my_button.dart';
import 'package:utility/components/my_textfield.dart';



class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _pw2Controller = TextEditingController();

  RegisterPage({super.key, this.onTap});

  final void Function()? onTap;
  register(context) {
    final auth = AuthService();

    if(_pwController.text == _pw2Controller.text) {
      try {
        auth.signUpWithEmailPassword(_emailController.text, _pwController.text);
    
      } catch (e) {
        showDialog(context: context, builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ));
      }
      }
    else {
      showDialog(context: context, builder: (context) => const AlertDialog(
        title: Text("Password need to match !"),
      ));
    }
    
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.broken_image, size: 50,),
            const Text("R E G I S T E R"),
            const SizedBox(height: 50,),
            MyTextField(
              hintText: 'Email',
              obscureText: false,
              controller: _emailController,
            ),
            const SizedBox(height: 5,),
            MyTextField(
              hintText: 'Password', 
              obscureText: true,
              controller: _pwController,
            ),
            const SizedBox(height: 5,),
            MyTextField(
              hintText: 'Confirm password', 
              obscureText: true,
              controller: _pw2Controller,
            ),
            const SizedBox(height: 10,),
            
            // LOG IN BUTTON
            GestureDetector(
              onTap: () => register(context),
              child: const MyButton(text: "Register"),
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already a member ? ", style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary
                  )),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Log In", 
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary
                    ),
                  )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}