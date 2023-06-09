import 'dart:convert';
import 'dart:developer';
import 'package:answer_five/core/network/network_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:http/http.dart' as http;

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/constants/string_constants.dart';
import '../models/trivia_model.dart';

abstract class RemoteDataSource {
  Future<TriviaModel> getTrivia();

  Future<int> getTodayQuestionNumber();

  Future<void> updateTodayQuestionNumber();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client _client;
  final NetworkInfo _networkInfo;
  final FirebaseDatabase _firebaseDatabase;
  final FirebaseAuth _firebaseAuth;

  const RemoteDataSourceImpl(this._client, this._networkInfo,
      this._firebaseDatabase, this._firebaseAuth);

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

          final question = results["question"];
          final correctAnswer = results["correct_answer"];
          var incorrectAnswers = results["incorrect_answers"];

          var htmlDecoded = unescape.convert(question);
          results["question"] = htmlDecoded;

          htmlDecoded = unescape.convert(correctAnswer);
          results["correct_answer"] = htmlDecoded;

          incorrectAnswers =
              incorrectAnswers.map((answer) => unescape.convert(answer));

          final triviaModel = TriviaModel.fromJson(results);
          return triviaModel;
        } else {
          throw const ServerException();
        }
      } catch (error) {
        log(error.toString());
        throw const ServerException();
      }
    } else {
      throw const NetworkException();
    }
  }

  @override
  Future<int> getTodayQuestionNumber() async {
    if (await _networkInfo.isConnected) {
      try {
        final databaseEvent = await _firebaseDatabase
            .ref()
            .child(
                "players/${_firebaseAuth.currentUser!.uid}/statistic/todayQuestionNumber")
            .once();
        final questionNumber = databaseEvent.snapshot.value as int;
        return questionNumber;
      } catch (error) {
        log(error.toString());
        throw const ServerException();
      }
    } else {
      log(StringConstants.networkExceptionMessage);
      throw const NetworkException();
    }
  }

  @override
  Future<void> updateTodayQuestionNumber() async {
    if (await _networkInfo.isConnected) {
      try {
        final databaseEvent = await _firebaseDatabase
            .ref()
            .child(
                "players/${_firebaseAuth.currentUser!.uid}/statistic/todayQuestionNumber")
            .once();
        var questionNumber = databaseEvent.snapshot.value as int;
        questionNumber = questionNumber + 1;
        return await _firebaseDatabase
            .ref()
            .child("players/${_firebaseAuth.currentUser!.uid}/statistic/")
            .update({'todayQuestionNumber': questionNumber});
      } catch (error) {
        log(error.toString());
        throw const ServerException();
      }
    } else {
      log(StringConstants.networkExceptionMessage);
      throw const NetworkException();
    }
  }
}
