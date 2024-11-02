class Device {
  final String uuid;
  final String petUuid;
  final String serialNumber;
  final String status;

  Device({
    required this.uuid,
    required this.petUuid,
    required this.serialNumber,
    required this.status,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      uuid: json['uuid'],
      petUuid: json['petUuid'],
      serialNumber: json['serialNumber'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'petUuid': petUuid,
      'serialNumber': serialNumber,
      'status': status,
    };
  }
}
