import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_sosialmedia/auth/profile_cubit.dart';
import 'package:uas_sosialmedia/auth/profile_states.dart';
import 'package:uas_sosialmedia/components/my_text_filed.dart';
import 'package:uas_sosialmedia/page/profile_user.dart';

class EditProfilePage extends StatefulWidget {
  final ProfileUser user;

  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final bioTextController = TextEditingController();

  void updateProfile() async{

    final profileCubit = context.read<ProfileCubit>();

    if (bioTextController.text.isNotEmpty) {
      profileCubit.updateProfile(
        uid: widget.user.uid,
        newBio: bioTextController.text,
        );
    }
  }

  // UI
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        // profile loading..
          if (state is ProfileLoading) {
            return const Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text("Uploading...")
                  ],
                ),
              ),
            );
          }else {
            return buildEditPage();
          }
          
        
      },
      listener: (context, state) {
        if (state is ProfileLoaded) {
          Navigator.pop(context);
        }
      },
    );
  }

  Widget buildEditPage({double uploadProgress = 0.0}) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Edit Profile"),
        foregroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          //save button

          IconButton(
            onPressed: updateProfile,
            icon:const Icon(Icons.upload)
            ),
        ],
      ),
      body: Column(
        children: [
          // profile picture

          // bio
         const Text("Bio"),

         const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: MyTextField(
              controller: bioTextController,
              hinText: widget.user.bio,
              obscureText: false,
              ),
          ),
        ],
      ),
    ); 
  }
}
