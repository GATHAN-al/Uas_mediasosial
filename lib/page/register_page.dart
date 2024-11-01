import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_sosialmedia/auth/auth_cubit.dart';
import 'package:uas_sosialmedia/components/my_button.dart';
import 'package:uas_sosialmedia/components/my_text_filed.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? togglePages;
  const RegisterPage({super.key, required this.togglePages});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
final pwController = TextEditingController();
final nameController = TextEditingController();
final confirmPwController = TextEditingController();


void register() {
  final String name = nameController.text;
  final String email = emailController.text;
  final String pw = pwController.text;
  final String confirmPw = confirmPwController.text;

  final authCubit = context.read<AuthCubit>();

  // Memeriksa jika semua field telah diisi
  if (email.isNotEmpty && name.isNotEmpty && pw.isNotEmpty && confirmPw.isNotEmpty) {
    // Memeriksa jika password dan konfirmasi password cocok
    if (pw == confirmPw) {
      authCubit.register(name, email, pw);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match!")),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please complete all fields")),
    );
  }
}


@override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    pwController.dispose();
    confirmPwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            
                // logo
                Icon(
                  Icons.lock_open_rounded,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
            
                const SizedBox(height: 50),
                //welcome
                Text("Lets create an account for you",
                style: TextStyle(color:  Theme.of(context).colorScheme.primary,
                fontSize: 16,
                ),
                ),
            
                              const SizedBox(height: 25),
            
            
                //email 
                MyTextField(
                  controller:nameController,
                  hinText: "Name", 
                  obscureText: false,
                  ),

                                const SizedBox(height: 10),
                MyTextField(
                  controller:emailController,
                  hinText: "Email", 
                  obscureText: false,
                  ),

                                const SizedBox(height: 10),

            
                //password
                 MyTextField(
                  controller:pwController,
                  hinText: "Password", 
                  obscureText: true,
                  ),
                                const SizedBox(height: 10),

            
                //password
                 MyTextField(
                  controller:confirmPwController,
                  hinText: "Confirm Password", 
                  obscureText: true,
                  ),

                        const SizedBox(height: 25),

            
                //register button
                MyButton(
                  onTap: register,
                   text: "Register",
                   ),

                   const SizedBox(height: 50),
            
                // not a member? register now
               // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already a member? ",
                    style: TextStyle(color: Theme.of(context).colorScheme.primary),
                    ),
                    GestureDetector(
                      onTap: widget.togglePages,
                      child: Text(" Login now",
                      style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                      ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        ),
    );
  }
}