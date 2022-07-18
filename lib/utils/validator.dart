class Validators {
  static String harmonize(String? value) =>
      value == null ? "" : value.replaceAll(",", "").trim();

  static String? validateEmail(String? value) {
    const Pattern emailPattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final regex = RegExp(emailPattern.toString());
    value = harmonize(value);
    if (value.isEmpty || !regex.hasMatch(value)) {
      return "Invalid email address";
    }
    return null;
  }

  static String? Function(String?) validatePassword({int minLength = 8}) {
    return (String? value) {
      value = harmonize(value);

      if (value.isEmpty) {
        return "Password is required";
      }
      if (value.length < minLength) {
        return "Password must be at least $minLength characters";
      }
      return null;
    };
  }
}
