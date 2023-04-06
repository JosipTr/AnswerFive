import 'dart:convert';
import 'dart:developer';
import 'package:answer_five/core/network/network_info.dart';
import 'package:http/http.dart' as http;

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/constants/string_constants.dart';
import '../models/trivia_model.dart';

abstract class RemoteDataSource {
  Future<TriviaModel> getTrivia();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client _client;
  final NetworkInfo _networkInfo;

  const RemoteDataSourceImpl(this._client, this._networkInfo);

  @override
  Future<TriviaModel> getTrivia() async {
    if (await _networkInfo.isConnected) {
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
      } catch (error) {
        log(error.toString());
        throw const ServerException();
      }
    }
    throw const NetworkException();
  }
}
