import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_sosialmedia/auth/profile_repo.dart';
import 'package:uas_sosialmedia/auth/profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  final ProfileRepo profileRepo;

  // Pastikan ProfileInitial() adalah instance dari ProfileStates
  ProfileCubit({required this.profileRepo}) : super(ProfileInitial());


// fetch user profile using repo
Future<void> fetchUserProfile(String uid) async {
  try {
    emit(ProfileLoading());
    final user = await profileRepo.fetchUserProfile(uid);
   if (user != null){
    emit(ProfileLoaded(user));
   } else {
    emit(ProfileError("User not found"));
   }
  }catch (e) {
    emit(ProfileError(e.toString()));
  }

 
}
 
//update bio and or profile picture
Future<void> updateProfile({
  required String uid,
  String? newBio,
})async {
  emit(ProfileLoading());

  try {
    final currentUser = await profileRepo.fetchUserProfile(uid);

    if(currentUser == null) {
      emit(ProfileError("Failed to fetch user for profile update"));
      return;
    }

    // profile picture update


    // update new profile
    final updateProfile = 
    currentUser.copyWith(newBio: newBio ?? currentUser.bio);


    // update in repo
    await profileRepo.updateProfile(updateProfile);

    // update profile
    await fetchUserProfile(uid);

  }
  catch (e) {
    emit(ProfileError("Error updating profile$e"));
  }
}

}