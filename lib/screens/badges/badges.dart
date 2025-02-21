import 'package:flutter/material.dart';

class Badges{
  final String badgeId;
  final String name;
  final String imageUrl;

  Badges({
    required this.badgeId,
    required this.name,
    required this.imageUrl,
  });

  factory Badges.fromMap(Map<String, dynamic> map){
    return Badges(
      badgeId: map['badge_id'] as String,
      name: map['name'] as String,
      imageUrl: map['image_url'] as String,
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'badge_id': badgeId,
      'name': name,
      'image_url': imageUrl,
    };
  }
}