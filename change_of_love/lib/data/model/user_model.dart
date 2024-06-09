class Usermodel {
  String email;
  String username;
  String bio;
  final String city;
  final String district;
  String profile;
  List following;
  List followers;
  Usermodel(this.bio, this.email, this.followers, this.following, this.profile,
      this.username, this.city, this.district);
}
