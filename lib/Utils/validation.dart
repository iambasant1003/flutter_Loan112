

String? validateDateOfBirth(String? value){
  if (value == null || value.isEmpty) {
    return 'Please enter your date of birth';
  }
  try {
    final parts = value.split('-');
    if (parts.length != 3) throw FormatException();
    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);
    final dob = DateTime(year, month, day);

    final today = DateTime.now();
    final age = today.year - dob.year -
        ((today.month < dob.month || (today.month == dob.month && today.day < dob.day)) ? 1 : 0);

    if (age < 18) {
      return 'You must be at least 18 years old';
    }
  } catch (e) {
    return 'Enter date in format dd/MM/yyyy';
  }
  return null;
}

String? validateIndianPinCode(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your PIN code';
  }
  if (!RegExp(r'^[1-9][0-9]{5}$').hasMatch(value)) {
    return 'Enter a valid 6-digit PIN code';
  }
  return null; // ✅ valid
}

String? validatePanCard(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your PAN card number';
  }

  const pattern = r'^[A-Z]{5}[0-9]{4}[A-Z]$';
  final regExp = RegExp(pattern);

  if (!regExp.hasMatch(value)) {
    return 'Enter a valid PAN card number';
  }

  return null; // ✅ valid
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }

  // simple and widely used email regex
  const pattern =
      r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$';

  final regExp = RegExp(pattern);

  if (!regExp.hasMatch(value)) {
    return 'Enter a valid email address';
  }

  return null; // ✅ valid
}

