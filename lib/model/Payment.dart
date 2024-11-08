class Payment {
  final String uuid;
  final String subscriptionUuid;
  final double amount;
  final String paymentDate;
  final String paymentMethod;
  final String currency;

  Payment({
    required this.uuid,
    required this.subscriptionUuid,
    required this.amount,
    required this.paymentDate,
    required this.paymentMethod,
    required this.currency,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      uuid: json['uuid'],
      subscriptionUuid: json['subscriptionUuid'],
      amount: json['amount'],
      paymentDate: json['paymentDate'],
      paymentMethod: json['paymentMethod'],
      currency: json['currency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'subscriptionUuid': subscriptionUuid,
      'amount': amount,
      'paymentDate': paymentDate,
      'paymentMethod': paymentMethod,
      'currency': currency,
    };
  }
}
