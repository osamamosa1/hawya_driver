class UserProfileModel {
  final int id;
  final String name;
  final String username;
  final String mobile;
  final String email;
  final String city;
  final String nationalId;
  final String walletLimit;
  final String image;

  UserProfileModel({
    required this.id,
    required this.name,
    required this.username,
    required this.mobile,
    required this.email,
    required this.city,
    required this.nationalId,
    required this.walletLimit,
    required this.image,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    final data = json['message'];
    return UserProfileModel(
      id: data['id'],
      name: data['name'] ?? '',
      username: data['username'] ?? '',
      mobile: data['mobile'] ?? '',
      email: data['email'] ?? '',
      city: data['city'] ?? '',
      nationalId: data['national_id'] ?? '',
      walletLimit: data['wallet_limit'] ?? '',
      image: data['image'] ?? '',
    );
  }

  UserProfileModel copyWithField(String field, String value) {
    switch (field) {
      case 'name':
        return UserProfileModel(
          id: id,
          name: value,
          username: username,
          mobile: mobile,
          email: email,
          city: city,
          nationalId: nationalId,
          walletLimit: walletLimit,
          image: image,
        );
      case 'username':
        return UserProfileModel(
          id: id,
          name: name,
          username: value,
          mobile: mobile,
          email: email,
          city: city,
          nationalId: nationalId,
          walletLimit: walletLimit,
          image: image,
        );
      case 'mobile':
        return UserProfileModel(
          id: id,
          name: name,
          username: username,
          mobile: value,
          email: email,
          city: city,
          nationalId: nationalId,
          walletLimit: walletLimit,
          image: image,
        );
      case 'email':
        return UserProfileModel(
          id: id,
          name: name,
          username: username,
          mobile: mobile,
          email: value,
          city: city,
          nationalId: nationalId,
          walletLimit: walletLimit,
          image: image,
        );
      default:
        return this;
    }
  }
}
