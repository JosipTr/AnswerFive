class StringConstants {
  static const serverExceptionMessage = 'Server error ocurred';
  static const networkExceptionMessage = 'You have no Internet connection';
  static const responseCodeMessages = [
    'Code 0: Success Returned results successfully.',
    'Code 1: No Results Could not return results. The API doesn\'t have enough questions for your query. (Ex. Asking for 50 Questions in a Category that only has 20.)',
    'Code 2: Invalid Parameter Contains an invalid parameter. Arguements passed in aren\'t valid. (Ex. Amount = Five)',
    'Code 3: Token Not Found Session Token does not exist.',
    'Code 4: Token Empty Session Token has returned all possible questions for the specified query. Resetting the Token is necessary.',
    'There is no Code Response, something else is error'
  ];
  static const url = 'https://opentdb.com/api.php?amount=1&difficulty=easy';

  //Assets
  static const logo = "assets/images/answer_five_nobackground.png";

  static const photoUrlDefault =
      'https://firebasestorage.googleapis.com/v0/b/answerfive-15710.appspot.com/o/images%2FdefaultImage.PNG?alt=media&token=1332ca8e-96a2-4d99-8f6f-effa914b245b';
}
