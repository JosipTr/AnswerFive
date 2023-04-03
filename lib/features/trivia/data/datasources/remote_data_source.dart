import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/constants/string_constants.dart';
import '../models/trivia_model.dart';

abstract class RemoteDataSource {
  Future<TriviaModel> getTrivia();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client _client;

  const RemoteDataSourceImpl(this._client);

  @override
  Future<TriviaModel> getTrivia() async {
    try {
      final url = Uri.parse(StringConstants.url);
      final response = await _client.get(url);
      if (response.statusCode == 200) {
        final triviaModel = TriviaModel.fromJson(json.decode(response.body));
        final responseCode = triviaModel.responseCode;
        triviaModel.checkResponseCode(responseCode);
        return triviaModel;
      } else {
        throw const ServerException();
      }
    } catch (e) {
      log(e.toString());
      throw const ServerException();
    }
  }
}
