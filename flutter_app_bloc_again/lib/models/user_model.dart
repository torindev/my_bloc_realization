import 'dart:math';

import 'package:flutter/material.dart';
import 'package:prototype_helper/prototype_helper.dart';
import 'package:uuid/uuid.dart';

class UserModel with ChangeNotifier {
  final String id;
  String fullName;
  final String photoSmall;
  final String photoBig;
  int salary;

  UserModel({
    this.id,
    this.fullName,
    this.photoSmall,
    this.photoBig,
    this.salary,
  });

  void updateFields(String fullName, String salary) {
    this.fullName = fullName;
    this.salary = int.parse(salary);
    notifyListeners();
  }

  static UserModel randomFemale() {
    final photos = getFemaleSmallAndBigRandomPhotos();
    return UserModel(
      id: Uuid().v1(),
      fullName: randomFemaleFullName,
      photoSmall: photos[0],
      photoBig: photos[1],
      salary: Random().nextInt(2000) + 1000,
    );
  }

  static UserModel randomMale() {
    final photos = getMaleSmallAndBigRandomPhotos();
    return UserModel(
      id: Uuid().v1(),
      fullName: randomMaleFullName,
      photoSmall: photos[0],
      photoBig: photos[1],
      salary: Random().nextInt(2000) + 1000,
    );
  }
}
