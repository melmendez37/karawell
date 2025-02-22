import 'package:flutter/material.dart';

class Badges{
  final String id;
  final String name;
  final String imageUrl;

  Badges({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory Badges.fromMap(Map<String, dynamic> map){
    return Badges(
      id: map['id'] as String,
      name: map['name'] as String,
      imageUrl: map['image_url'] as String,
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
    };
  }
}