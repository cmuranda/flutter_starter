import 'dart:convert';

String mockFulfilmentApiResult = '{"fulfilmentResults":[{"checkName":"KYC","passed":true,"productIds":[7,5]},{"checkName":"Living Status","passed":true,"productIds":[7]},{"checkName":"Fraud","passed":false,"failureMessage":"Customer has  a current or pending Fraud Investigation","productIds":[7]},{"checkName":"Duplicate ID","passed":true,"productIds":[7]}]}';

Fulfilment fulfilmentFromJson(String str) => Fulfilment.fromJson(json.decode(str));

String fulfilmentToJson(Fulfilment data) => json.encode(data.toJson());

class Fulfilment {
  List<FulfilmentResult> fulfilmentResults;

  Fulfilment({
    required this.fulfilmentResults,
  });

  factory Fulfilment.fromJson(Map<String, dynamic> json) => Fulfilment(
    fulfilmentResults: List<FulfilmentResult>.from(json["fulfilmentResults"].map((x) => FulfilmentResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "fulfilmentResults": List<dynamic>.from(fulfilmentResults.map((x) => x.toJson())),
  };
}

class FulfilmentResult {
  String checkName;
  bool passed;
  List<int> productIds;
  String? failureMessage;

  FulfilmentResult({
    required this.checkName,
    required this.passed,
    required this.productIds,
    this.failureMessage,
  });

  factory FulfilmentResult.fromJson(Map<String, dynamic> json) => FulfilmentResult(
    checkName: json["checkName"],
    passed: json["passed"],
    productIds: List<int>.from(json["productIds"].map((x) => x)),
    failureMessage: json["failureMessage"],
  );

  Map<String, dynamic> toJson() => {
    "checkName": checkName,
    "passed": passed,
    "productIds": List<dynamic>.from(productIds.map((x) => x)),
    "failureMessage": failureMessage,
  };
}
