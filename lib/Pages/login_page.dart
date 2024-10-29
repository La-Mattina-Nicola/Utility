import 'package:flutter/material.dart';
import 'package:utility/services/auth/auth_service.dart';
import 'package:utility/components/my_button.dart';
import 'package:utility/components/my_textfield.dart';


class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  LoginPage({super.key, this.onTap});
  final void Function()? onTap;
  void login(BuildContext context) async {
    final auth = AuthService();

    try {
      await auth.signInWithEmailPassword(_emailController.text, _pwController.text);
    }
    catch (e) {
      // ignore: use_build_context_synchronously
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text(e.toString()),
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
            const Text("L O G I N"),
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
            const SizedBox(height: 10,),

            // LOG IN BUTTON
            GestureDetector(
              onTap: () => login(context),
              child: const MyButton(text: "Log In")
            ),
            
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not a user yet ? ", style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary
                  )),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "REGISTER", 
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