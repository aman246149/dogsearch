import 'dart:convert';

import 'package:dogs/features/errors/custom_error.dart';
import 'package:dogs/features/homepage/model/dogModel.dart';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;

class ApiCall {
  Future<Either<CustomError, List<DogModel>>> apicall() async {
    var url = Uri.parse("https://api.thedogapi.com/v1/breeds");
    List<DogModel> list = [];
    try {
      final resp = await http.get(url);
      var decodedJson = jsonDecode(resp.body);
      for (var i = 0; i < decodedJson.length; i++) {
        DogModel dog = DogModel.fromJson(decodedJson[i]);
        list.add(dog);
      }

      return Right(list);
    } catch (e) {
      return Left(CustomError(message: e.toString()));
    }
  }
}
