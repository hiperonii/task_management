class KeySymbols {
  KeySymbols._(this.value);

  final String value;

  static KeySymbols zero = KeySymbols._('0');
  static KeySymbols one = KeySymbols._('1');
  static KeySymbols two = KeySymbols._('2');
  static KeySymbols three = KeySymbols._('3');
  static KeySymbols four = KeySymbols._('4');
  static KeySymbols five = KeySymbols._('5');
  static KeySymbols six = KeySymbols._('6');
  static KeySymbols seven = KeySymbols._('7');
  static KeySymbols eight = KeySymbols._('8');
  static KeySymbols nine = KeySymbols._('9');

  @override
  String toString() {
    return 'Key_$value';
  }
}
