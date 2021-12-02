class PasswordValidator {
  const PasswordValidator();

  // static const specialCharacters = '\\^\$*.[\\]{}()?"!@#%&/\\\\,><\':;|_~`';
  // static const pattern = ''
  //     '^'
  //     '(?=.*[a-z])'
  //     '(?=.*[A-Z])'
  //     '(?=.*[0-9])'
  //     '(?=.*[$specialCharacters])'
  //     '[a-zA-Z0-9$specialCharacters]{8,}'
  //     '\$';

  // bool isValid(String password) {
  //   return RegExp(pattern).hasMatch(password);
  // }

  bool isConfirmationValid(String password, String confirmation) {
    return password == confirmation;
  }
}
