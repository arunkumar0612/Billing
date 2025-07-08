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

  static dynamic GST_validator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter GST number';
    }
    if (!RegExp(r'^[0-3][0-9][A-Z]{5}[0-9]{4}[A-Z][1-9A-Z]Z[A-Z0-9]$').hasMatch(value)) {
      return 'Please enter a valid 15-character GST number';
    }

    return null;
  }

  static dynamic PAN_validator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter PAN number';
    }

    // PAN format: 5 letters + 4 digits + 1 letter (e.g., ABCDE1234F)
    if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$').hasMatch(value)) {
      return 'Please enter a valid 10-character PAN number (e.g., ABCDE1234F)';
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
