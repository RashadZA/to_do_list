part of 'design_utils.dart';

class AppValidators {

  static String? emptyNullValidator(
    String? value, {
    String? errorMessage = "required!",
  }) {
    //TODO: Add Extra Validation If Needed
    if (value?.trim().isEmpty ?? true) return errorMessage;

    return null;
  }

}
