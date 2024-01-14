import 'dart:math';

String generatePassword({required int passwordLength}) {
  String smallerAlphabets = "abcdefghijklmnopqrstuvwxyz";
  String capitalAlphabets = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  String numbers = "1234567890";
  String symbols = "/#%?";
  final combination = smallerAlphabets + capitalAlphabets + numbers + symbols;

  var password = "";
  for (var i = 0; i < passwordLength; i++) {
    int guess = Random().nextInt(combination.length);
    password += combination[guess];
  }
  return password;
}
