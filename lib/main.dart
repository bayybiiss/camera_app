import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(new MaterialApp(
    title: "Kamera Uygulaması",
    debugShowCheckedModeBanner : false,
    theme: ThemeData(
      primaryColor: Color(0xFFF5FF),
    ),
    home: cameraApp(),
  ));
}

class cameraApp extends StatefulWidget{
  @override
  _cameraAppState createState() => _cameraAppState();
}

class _cameraAppState extends State<cameraApp>{
  File? imageFile;
  //Galeri acma kodu
  _openGallery(BuildContext context) async {
    var picture= await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture as File;
    });
    Navigator.of(context).pop(); //sabitleme
  }
  //Camera acma kodu
  _openCamera(BuildContext context) async {
    var picture= await ImagePicker.platform.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture as File;
    });
    Navigator.of(context).pop(); //sabitleme
  }

  Future<void> _showChoiseDialog(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text('Birini seçin!'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text("Galeri"),
                onTap: (){
                  _openGallery(context);
                },
              ),
              GestureDetector(
                child: Text("Kamera"),
                onTap: (){
                  _openCamera(context);
                },
              ),

            ],
          ),
        ),
      );
    });
  }
  Widget _decideImageView(){
    if(imageFile==null){
      return Text("Resim seçilmedi");
    }
    else
      {
        return Image.file(imageFile!,width: 400, height: 400,);
      }
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Ana Sayfa"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _decideImageView(),
              ElevatedButton(onPressed: (){
                _showChoiseDialog(context);
              }, child: Text("Resim Seçin"),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF00386),//arka plan rengi
                onPrimary: Colors.white, //metin rengi
                elevation: 5, //yükseltilmiş durum gölgesi
              ),),
            ],
          ),
        ),
      ),
    );
  }
}

