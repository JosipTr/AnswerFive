import 'dart:developer';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/constants/string_constants.dart';
import '../../domain/entities/trivia.dart';
import 'trivia_result_model.dart';

class TriviaModel extends Trivia {
  const TriviaModel({required super.responseCode, required super.results});

  factory TriviaModel.fromJson(Map<String, dynamic> json) {
    return TriviaModel(
      responseCode: json['response_code'],
      results: json['results'] != null
          ? (json['results'] as List<dynamic>)
              .map((result) => TriviaResultModel.fromJson(result))
              .toList()
          : [],
    );
  }

  void checkResponseCode(int responseCode) {
    switch (responseCode) {
      case 0:
        {
          log(StringConstants.responseCodeMessages[0]);
        }
        break;
      case 1:
        {
          log(StringConstants.responseCodeMessages[1]);
        }
        break;
      case 2:
        {
          log(StringConstants.responseCodeMessages[2]);
        }
        break;
      case 3:
        {
          log(StringConstants.responseCodeMessages[3]);
        }
        break;
      case 4:
        {
          log(StringConstants.responseCodeMessages[4]);
        }
        break;
      default:
        {
          log(StringConstants.responseCodeMessages[5]);
        }
        break;
    }
    if (responseCode == 0) {
      return;
    } else {
      throw const ServerException();
    }
  }
}
