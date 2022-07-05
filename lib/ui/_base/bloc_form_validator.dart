import 'package:base32/base32.dart';
import 'package:code/_res/R.dart';
import 'package:code/global_regexp.dart';
import 'package:flutter/widgets.dart';

const String EMAILREGEXP =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
const password_upper_case_letter = '[A-Z]';
const password_number_letter = '[0-9]';
const password_lower_case_letter = '[a-z]';
const password_especial_char = "^.*[@#\$%^&*-+=!?].*\$";
const strongPassword = "^(?=.[0-9])(?=.[a-z\u0430-\u044F])(?=.[A-Z\u0410-\u042F])(?=.[^a-zA-Z0-9\u0430-\u044F\u0410-\u042F]).{10,200}\$";
const mediumPassword = "^(?=.[0-9])(?=.[a-z\u0430-\u044F])(?=.*[A-Z\u0410-\u042F]).{8,200}\$";

class FormValidatorBloC {
  FormFieldValidator email() {
    FormFieldValidator validator = (value) {
      if (value.toString().isEmpty) {
        return R.string.fieldRequired;
      } else {
        return _validateEmail(value);
      }
    };
    return validator;
  }

  FormFieldValidator formValidatorEmailCommaSeparatedNotRequired() {
    FormFieldValidator validator = (value) {
      final texts = value.toString().split(',');
      for(var i = 0; i < texts.length; i++) {
        final element = texts[i];
        if(element.trim().isNotEmpty && _validateEmail(element.trim()) != null)
          return R.string.missingEmailFormat;
      }
      return null;
    };
    return validator;
  }

  FormFieldValidator emailNotRequired() {
    FormFieldValidator validator = (value) {
      return _validateEmail(value);
    };
    return validator;
  }

  String? _validateEmail(String value) {
    RegExp regex = RegExp(EMAILREGEXP);
    if (!regex.hasMatch(value))
      return R.string.missingEmailFormat;
    else
      return null;
  }

  FormFieldValidator password() {
    FormFieldValidator validator = (value) {
      if (value == null ||
          value.toString().isEmpty ||
          value.toString().length < 8) {
        return R.string.passwordRestriction;
      } else if (!RegExp(password_upper_case_letter)
          .hasMatch(value.toString())) {
        return R.string.passwordRestriction;
      } else if (!RegExp(password_lower_case_letter)
          .hasMatch(value.toString())) {
        return R.string.passwordRestriction;
      } else if (!RegExp(password_number_letter).hasMatch(value.toString())) {
        return R.string.passwordRestriction;
      }
      // else if(!RegExp(strongPassword).hasMatch(value.toString()) ||
      //     !RegExp(mediumPassword).hasMatch(value.toString())){
      //   return R.string.passwordRestriction;
      // }
      else {
        return null;
      }
    };
    return validator;
  }

  FormFieldValidator passwordLogin() {
    FormFieldValidator validator = (value) {
      if (value == null ||
          value.toString().isEmpty) {
        return R.string.fieldPassword;
      } else {
        return null;
      }
    };
    return validator;
  }

  FormFieldValidator passwordMatch(String match) {
    FormFieldValidator validator = (value) {
      if (value != match) {
        return R.string.passwordMustMatch;
      } else {
        return null;
      }
    };
    return validator;
  }

  FormFieldValidator alphanumericRoomNameWithoutSpaces() {
    FormFieldValidator validator = (value) {
      return (value?.toString().trim().isEmpty == true)
          ? R.string.fieldRequired
          : !GlobalRegexp.genericNameWithoutSpace.hasMatch(value?.toString().trim() ?? "")
          ? R.string.nameTextWarningWithoutSpaces
          : null;
    };
    return validator;
  }

  FormFieldValidator otpLabelValidator() {
    FormFieldValidator validator = (value) {
      return (value?.toString().trim().isEmpty == true)
          ? R.string.fieldRequired
          : !GlobalRegexp.otpLabel.hasMatch(value?.toString().trim() ?? "")
          ? R.string.otpLabelWarning
          : null;
    };
    return validator;
  }

  FormFieldValidator otpSecretValidator() {
    FormFieldValidator validator = (value) {
      try {
        return (value?.toString().trim().isEmpty == true)
            ? R.string.fieldRequired
            : base32.decodeAsString(value).isEmpty
            ? R.string.invalidBase32Chars
            : null;
      } catch (ex) {
        return R.string.invalidBase32Chars;
      }
    };
    return validator;
  }

  FormFieldValidator alphanumericRoomName() {
    FormFieldValidator validator = (value) {
      return (value?.toString().trim().isEmpty == true)
          ? R.string.fieldRequired
          : !GlobalRegexp.genericName.hasMatch(value?.toString().trim() ?? "")
            ? R.string.nameTextWarning
            : null;
    };
    return validator;
  }

  FormFieldValidator required() {
    FormFieldValidator validator = (value) {
      return (value?.toString().trim().isEmpty == true)
          ? R.string.fieldRequired
          : null;
    };
    return validator;
  }

  FormFieldValidator chars18() {
    FormFieldValidator validator = (value) {
      return (value?.toString().trim().isEmpty == true)
          ? R.string.fieldRequired
          : (value.toString().trim().length > 18) ? R.string.fieldMax18 : null;
    };
    return validator;
  }
}
