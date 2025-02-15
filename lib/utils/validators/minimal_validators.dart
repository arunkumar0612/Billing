class Validators {
  static dynamic phnNo_validator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter contact number';
    }
    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Please enter a valid 10-digit number';
    }
    return null;
  }

  static dynamic email_validator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the email';
    }
    if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static dynamic GST_validator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter GST number';
    }
    if (!RegExp(r'^[0-9]{15}$').hasMatch(value)) {
      return 'Please enter a valid 15-digit GST number';
    }
    return null;
  }

  static String? fileValidator(value) {
    if (value == null) {
      return "File is required!";
    }
    return null;
  }
}
