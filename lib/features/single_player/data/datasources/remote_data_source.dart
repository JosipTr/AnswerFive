import 'dart:convert';
import 'dart:developer';
import 'package:answer_five/core/network/network_info.dart';
import 'package:html_unescape/html_unescape_small.dart';
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
        final response = await _client
            .get(url, headers: {'Content-Type': 'application/json'});
        if (response.statusCode == 200) {
          final unescape = HtmlUnescape();
          Map<String, dynamic> results =
              ((json.decode(response.body))["results"].first);
          // Map<String, dynamic> results = (jsonMap["results"]).first;

          final question = results["question"];
          final correctAnswer = results["correct_answer"];
          var incorrectAnswers = results["incorrect_answers"];

          var htmlDecoded = unescape.convert(question);
          results["question"] = htmlDecoded;

          htmlDecoded = unescape.convert(correctAnswer);
          results["correct_answer"] = htmlDecoded;
          print(incorrectAnswers);

          incorrectAnswers =
              incorrectAnswers.map((answer) => unescape.convert(answer));

          print(incorrectAnswers);
          final triviaModel = TriviaModel.fromJson(results);
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
