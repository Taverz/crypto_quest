
import 'package:equatable/equatable.dart';


abstract class FieldValidater {
  String get field;
  ValidationException? validate(Map input);
}

enum ValidationException {
  requiredField, 
  invalidField,
}

abstract class Validation {
  ValidationException? validate({
    required String field,
    required Map input
  });
}


class ValidationComposite implements Validation {
  final List<FieldValidater> validations;

  ValidationComposite(this.validations);

  ValidationException? validate({ required String field, required Map input}) {
    ValidationException? error;
    for (final validation in validations.where((v) => v.field == field)) {
      error = validation.validate(input);
      if (error != null) {
        return error;
      }
    }
    return error;
  }
}

Validation makeSignUpValidation() => ValidationComposite(makeSignUpValidations());

List<FieldValidater> makeSignUpValidations() => [
  ...ValidaterBuilder.field('name').required().min(3).build(),
  ...ValidaterBuilder.field('email').required().email().build(),
  ...ValidaterBuilder.field('password').required().min(3).build(),
  ...ValidaterBuilder.field('passwordConfirmation').required().compare('password').build()
];


class ValidaterBuilder {
  static ValidaterBuilder? _instatnce;
  String fieldName;
  List<FieldValidater> validations = [];

  ValidaterBuilder._(this.fieldName);

  List<FieldValidater> build() => validations;

  static  ValidaterBuilder field(String fieldName){
    _instatnce = ValidaterBuilder._(fieldName);
    return _instatnce!;
  }
  ValidaterBuilder required() {
    validations.add(RequiredFieldValidation(fieldName));
    return this;
  }

  ValidaterBuilder email() {
    validations.add(EmailValidation(fieldName));
    return this;
  }

  ValidaterBuilder min(int size) {
    validations.add(MinLengthValidation(field: fieldName, size: size));
    return this;
  }

  ValidaterBuilder compare(String fieldToCompare) {
    validations.add(CompareFieldValidater(field: fieldName, fieldToCompare: fieldToCompare));
    return this;
  }
  
}

class RequiredFieldValidation extends Equatable implements FieldValidater {
  final String field;

  List get props => [field];

  RequiredFieldValidation(this.field);

  ValidationException? validate(Map input) =>
    input[field]?.isNotEmpty == true ? null : ValidationException.requiredField;
}

class CompareFieldValidater extends Equatable implements FieldValidater {
  final String field;
  final String fieldToCompare;
  List get props => [field, fieldToCompare];

  CompareFieldValidater({required this.field, required this.fieldToCompare});
  
  @override
  ValidationException? validate(Map input) => 
    input[field] != null
    && input[fieldToCompare] != null
    && input[field] != input[fieldToCompare]
      ? ValidationException.invalidField
      : null;

}


class EmailValidation extends Equatable implements FieldValidater {
  final String field;

  List get props => [field];

  EmailValidation(this.field);

  ValidationException? validate(Map input) {
    final regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final isValid = input[field]?.isNotEmpty != true || regex.hasMatch(input[field]);
    return isValid ? null : ValidationException.invalidField;
  }
}

class MinLengthValidation extends Equatable implements FieldValidater {
  final String field;
  final int size;

  List get props => [field, size];

  MinLengthValidation({ required this.field, required this.size});

  ValidationException? validate(Map input) =>
    input[field] != null
    && input[field].length >= size
      ? null
      : ValidationException.invalidField;
}