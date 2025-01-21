import 'package:hive/hive.dart';

part 'customer_data.g.dart'; // 자동 생성된 파일 import

@HiveType(typeId: 0)
class CustomerData {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String room;

  CustomerData({required this.name, required this.room});
  // toString() 메서드를 오버라이드하여 객체 내용을 문자열로 출력
  @override
  String toString() {
    return 'CustomerData(name: $name, room: $room)';
  }
}
