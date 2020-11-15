import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class CloudStorageService {
  static CloudStorageService instance = CloudStorageService();

  FirebaseStorage _storage;
  Reference _baseRef; //Use reference instead of StorageReference
  //more info https://stackoverflow.com/questions/64764111/undefined-class-storagereference-when-using-firebase-storage/64764390

  String _profileImages = "profile_images";

  CloudStorageService() {
    _storage = FirebaseStorage.instance;
    _baseRef = _storage.ref();
  }

  // Future<StorageTaskSnapshot> uploadUserImage(String _uid, File _image) {
  //   try {
  //     return _baseRef
  //         .child(_profileImages)
  //         .child(_uid)
  //         .putFile(_image)
  //         .onComplete;
  //   } catch (e) {}
  // }
}
