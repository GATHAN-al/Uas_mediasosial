import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_sosialmedia/auth/auth_cubit.dart';
import 'package:uas_sosialmedia/auth/auth_page.dart';
import 'package:uas_sosialmedia/auth/auth_stage.dart';
import 'package:uas_sosialmedia/auth/profile_cubit.dart';
import 'package:uas_sosialmedia/data/firebase_auth_repo.dart';
import 'package:uas_sosialmedia/data/firebase_profile_repo.dart';
import 'package:uas_sosialmedia/page/home_page.dart';
import 'package:uas_sosialmedia/theme/light_mode.dart';



class MyApp extends StatelessWidget {
  final authRepo = FirebaseAuthRepo();

  final profileRepo = FirebaseProfileRepo();
  
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers:[
      //auth cubit
      BlocProvider<AuthCubit>(create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
      ),

     // profile cubit
      BlocProvider<ProfileCubit>(create: (context) => ProfileCubit(profileRepo: profileRepo),
      ),
    ],
     
     child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        home: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, authState) {
            print(authState);

            // Menampilkan halaman login dan register
            if (authState is Unauthenticated) {
              return const AuthPage();
            }

            // Menampilkan halaman utama jika pengguna telah berhasil login
            if (authState is Authenticated) {
              return const HomePage();
            }

            // Menampilkan indikator loading jika status masih belum ditentukan
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
        ),
      ),
     );
     
  }
}
