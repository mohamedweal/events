// lib/UI/Common/Validators.dart

bool isValidEmail(String? email) {
  // Check for null or empty string immediately
  if (email == null || email.trim().isEmpty) {
    return false;
  }

  // Your provided regex for email validation
  return RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  ).hasMatch(email.trim());
}

bool isValidPhone(String? phone){
  // Check for null or empty string immediately
  if(phone == null || phone.trim().isEmpty) {
    return false;
  }

  // Your provided regex for 11 digits
  return RegExp(r"^[0-9]{11}$")
      .hasMatch(phone.trim());
}