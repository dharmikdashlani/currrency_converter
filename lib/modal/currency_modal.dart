class AllCurrency {
  final String code;
  final double value;

  AllCurrency({
    required this.code,
    required this.value,
  });

  factory AllCurrency.fromMap({required Map data}) {
    return AllCurrency(
      code: data['code'],
      value: double.parse(data['value'].toString())
    );
  }
}
