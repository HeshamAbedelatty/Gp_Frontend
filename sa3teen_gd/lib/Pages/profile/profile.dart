import 'package:gp_screen/Pages/listofMyGroupsPage/getAPI.dart';
import 'package:gp_screen/Pages/profile/profileModel.dart';

class ProfileService {
  // Adjusted getProfile method in ProfileService

  Future<ProfileModel> getProfile(String accessToken) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      //"Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };

    try {
      dynamic data = await Api().anotherget(
        url: 'http://10.0.2.2:8000/user/',
        headers: headers,
      );

      ProfileModel profile = ProfileModel.fromJson(data);
      print(profile);
      return profile;
    } catch (e) {
      print('Error fetching profile: $e');
      throw e;
    }
  }
}
