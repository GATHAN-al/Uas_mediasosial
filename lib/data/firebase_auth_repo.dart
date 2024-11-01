import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uas_sosialmedia/app_user.dart';
import 'package:uas_sosialmedia/auth/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;


  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: '',
      );

      return user;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<AppUser?> registerWithEmailPassword(String name, String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: name,
      );
       // Save user data to Firestore
      await firebaseFirestore
      .collection("users")
      .doc(user.uid)
      .set(user.toJson());

      return user;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }


  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    final  firebaseUser = firebaseAuth.currentUser;
    if (firebaseUser != null) {
      
    
    return AppUser(
        uid: firebaseUser.uid,
        email: firebaseUser.email!,
        name: '',
      );
    }
    return null;
    }
  }

