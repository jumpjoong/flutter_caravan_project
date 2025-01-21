import 'package:flutter/material.dart';
import 'package:flutter_firebase_study/app/hive_type/customer_data.dart';
import 'package:flutter_firebase_study/app/pages/dailyroom/dailystatus.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DailyRoom extends StatefulWidget {
  final String title;
  const DailyRoom({super.key, required this.title});

  @override
  State<DailyRoom> createState() => _DailyRoomState();
}

class _DailyRoomState extends State<DailyRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ValueListenableBuilder(
        valueListenable:
            Hive.box<List<CustomerData>>('caravanCustomer').listenable(),
        builder: (context, box, _) {
          // `box.values.toList()`로 값을 List로 변환 후, cast<CustomerData>()
          final customerData =
              box.get('customerData', defaultValue: <CustomerData>[])
                  as List<CustomerData>;
          if (customerData.isEmpty) {
            return Center(child: Text('데이터가 없습니다'));
          }
          // 101동부터 순서대로 정렬
          customerData.sort((a, b) => a.room.compareTo(b.room));

          return ListView.builder(
            itemCount: customerData.length,
            itemBuilder: (context, index) {
              final data = customerData[index];
              return InkWell(
                highlightColor: Colors.blue.withOpacity(0.5),
                onLongPress: () {
                  print(data.name);
                },
                child: ListTile(
                  title: Text(data.name), // 고객 이름
                  subtitle: Text(data.room), // 고객 방 번호
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DailyStatus(),
            ),
          );
        },
        child: Text('작성하기'),
      ),
    );
  }
}
