import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_sosialmedia/app_user.dart';
import 'package:uas_sosialmedia/auth/auth_cubit.dart';
import 'package:uas_sosialmedia/auth/profile_cubit.dart';
import 'package:uas_sosialmedia/auth/profile_states.dart';
import 'package:uas_sosialmedia/components/bio_box.dart';

import 'edit_profile_page.dart';


class ProfilePage extends StatefulWidget {
    final String uid;

  const ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}


class _ProfilePageState extends State<ProfilePage> {
    late final authCubit = context.read<AuthCubit>();
      late final profileCubit = context.read<ProfileCubit>();



      late AppUser? currentUsers = authCubit.currentUser;
@override
  void initState() {
    super.initState();

    // Load user profile data
    profileCubit.fetchUserProfile(widget.uid);
   // currentUsers = authCubit.currentUser;
  }


  @override
    //Scallfold
     Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          // Get loaded user
          final user = state.profileUser;


          // Scafflod

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(user.name),
              foregroundColor: Theme.of(context).colorScheme.primary,
              actions: [
                // edit profile button
                IconButton(
                  onPressed: () => Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (context) =>  EditProfilePage(user: user),
                  )), 
                  icon: const Icon(Icons.settings),
                  ),
              ],
            ),


            // BODY
            body: Column(
              children: [
                Text(user.email, style: TextStyle(color:  Theme.of(context).colorScheme.primary),
                ),
            
                const SizedBox(height: 25),
            
                Container(
                  decoration: BoxDecoration(
                    color:  Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: 120,
                  width: 120,
                  padding: const EdgeInsets.all(25),
                  child:  Center(
                    child: Icon(Icons.person,
                    size: 72,
                    color:  Theme.of(context).colorScheme.primary,
                    
                    ),
                  ),
                ),
                const SizedBox(height: 25),
            
                //bio
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Row(
                    children: [
                      Text("Bio",
                      style: TextStyle(
                       color:  Theme.of(context).colorScheme.primary,
                          
                      ),
                      ),
                    ],
                  ),
                ),

               const SizedBox(height: 10),

              BioBox(text: user.bio),

               Padding(
                  padding: const EdgeInsets.only(left: 25.0, top: 25),
                  child: Row(
                    children: [
                      Text("Posts",
                      style: TextStyle(
                       color:  Theme.of(context).colorScheme.primary,
                          
                      ),
                      ),
                    ],
                  ),
                ),
            
              ],
            ),
          );
        } else if (state is ProfileLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text("No profile found.."),
            ),
          );
        }
      },
    );
  }
}