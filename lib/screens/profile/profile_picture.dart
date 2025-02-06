import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key});

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture>{
  File? _imageFile;

  //choose image
  Future pickImage() async {
    //picker
    final ImagePicker picker = ImagePicker();

    //choose from gallery
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    //update image preview
    if(image != null){
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  //upload image
  Future uploadImage() async {
    if(_imageFile == null) return;

    //generate unique file path
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final path = 'uploads/$fileName';

    //upload to db storage
    await Supabase.instance.client.storage
        //upload to this bucket
        .from('images')
        .upload(path, _imageFile!).then((value) => 
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Picture successfully added.')))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload picture'),
      ),
      body: Center(
        child: Column(
          children: [
            //image preview
            _imageFile != null ? Image.file(_imageFile!) :
            const Text('No picture added..'),

           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               //choose image button
               ElevatedButton(
                   onPressed: pickImage,
                   style: ElevatedButton.styleFrom(
                       backgroundColor: Color(0xff027373),
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10),
                       )
                   ),
                   child: Text(
                     'Choose image',
                     style: TextStyle(
                         fontFamily: 'DM_Sans',
                         fontWeight: FontWeight.bold,
                         color: Color(0xFFF2F2F2)
                     ),
                   )
               ),

               //upload image button
               ElevatedButton(
                   onPressed: uploadImage,
                   style: ElevatedButton.styleFrom(
                       backgroundColor: Color(0xff027373),
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10),
                       )
                   ),
                   child: Text(
                     'Upload',
                     style: TextStyle(
                         fontFamily: 'DM_Sans',
                         fontWeight: FontWeight.bold,
                         color: Color(0xFFF2F2F2)
                     ),
                   )
               ),
             ],
           )
          ], // Replace with your UI
        ),
      )
    );
  }


}