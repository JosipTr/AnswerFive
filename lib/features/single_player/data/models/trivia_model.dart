import 'dart:developer';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/constants/string_constants.dart';
import '../../domain/entities/trivia.dart';

class TriviaModel extends Trivia {
  const TriviaModel(
      {required super.category,
      required super.type,
      required super.difficulty,
      required super.question,
      required super.answers,
      required super.correctAnswer});

  factory TriviaModel.fromJson(Map<String, dynamic> json) {
    return TriviaModel(
      category: json["category"],
      type: json["type"],
      difficulty: json["difficulty"],
      question: json["question"],
      correctAnswer: json["correct_answer"],
      answers: List<String>.from(json["incorrect_answers"])
        ..add(json["correct_answer"]),
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
