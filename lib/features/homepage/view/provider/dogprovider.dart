import 'package:dogs/features/homepage/data/apicall.dart';
import 'package:dogs/features/homepage/model/dogModel.dart';
import 'package:flutter/cupertino.dart';

class DogProvider extends ChangeNotifier {
  bool isLoading = false;
  List<DogModel> dogs = [];
  String errormessage = "";

  Future<void> fetchDogs() async {
    isLoading = true;
    notifyListeners();
    final resp = await ApiCall().apicall();

    if (!resp.isLeft) {
      resp.map((right) => dogs = right);
      notifyListeners();
    }

    if (resp.isLeft) {
      resp.mapLeft((left) => errormessage = left.message);
      print(errormessage);
    }
    isLoading = false;
    notifyListeners();
  }
}
