import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uas_sosialmedia/auth/profile_repo.dart';
import 'package:uas_sosialmedia/page/profile_user.dart';

class FirebaseProfileRepo implements ProfileRepo {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<ProfileUser?> fetchUserProfile(String uid) async {
    try {
      final userDoc = await firebaseFirestore.collection('users').doc(uid).get();

      if (userDoc.exists) {
        final userData = userDoc.data();

        if (userData != null) {
          return ProfileUser(
            uid: uid,
            email: userData['email']?? "",
            name: userData['name']?? "",
            bio: userData['bio'] ?? "",
            profileImageUrl: userData['profileImageUrl'].toString(),
          );
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> updateProfile(ProfileUser updateProfile) async {
    try {
      await firebaseFirestore.collection('users').doc(updateProfile.uid).update({
        'bio': updateProfile.bio,
        'profileImageUrl': updateProfile.profileImageUrl,
      });
    } catch (e) {
      throw Exception("Failed to update profile: $e");
    }
  }
}
