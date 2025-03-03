class Profile{
  final String id;
  final String? username;
  final String? tagline;
  final String? phone;
  final String? imageUrl;

  Profile({
    required this.id,
    this.username,
    this.tagline,
    this.phone,
    this.imageUrl
  });

  //map -> profile
  factory Profile.fromMap(Map<String, dynamic> map){
    return Profile(
      id: map['id'] as String,
      username: map['username'] as String?,
      tagline: map['tagline'] as String?,
      phone: map['phone'] as String?,
      imageUrl: map['image_url'] as String?
    );
  }

  //profile -> map
  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'username': username,
      'tagline': tagline,
      'phone': phone,
      'imageUrl': imageUrl
    };
  }
}

