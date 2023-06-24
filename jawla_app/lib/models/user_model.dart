class User {
  final String? name;
  final String? email;
  final String? phone;
  final String? city;
  final String? profilePic;
  final bool? isOwner;

  User({
    this.name,
    this.email,
    this.phone,
    this.city,
    this.profilePic,
    this.isOwner,
  });

  factory User.fromJson({required Map json}) {
    return User(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      city: json['city'],
      profilePic: json['profilePic'],
      isOwner: json['is_owner'],
    );
  }

  toMap() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "city": city,
      "profile_pic": profilePic,
      "is_owner": isOwner,
    };
  }
}
