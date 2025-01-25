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
  //길게 누르면 삭제 팝업창
  Future<void> _showDeletedialog({
    required BuildContext context,
    required String room,
    required String name,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('삭제하시겠습니까?'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('이름: $name'),
              Text('객실: $room'),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('취소'),
          ),
          ElevatedButton(
            onPressed: () => {
              _deleteCustomer(name: name, room: room),
              //팝업창 닫기
              Navigator.of(context).pop(),
            },
            child: Text('확인'),
          ),
        ],
      ),
    );
  }

  void _deleteCustomer({required String name, required String room}) async {
    //박스 참조
    Box<List<CustomerData>> box =
        Hive.box<List<CustomerData>>('caravanCustomer');
    //박스 데이터 가져오기
    List<CustomerData> customerData =
        box.get('customerData', defaultValue: <CustomerData>[])!;
    // 리스트에서 삭제할 데이터 찾기
    customerData.removeWhere(
        (customer) => customer.name == name && customer.room == room);
    // 삭제 후 저장
    await box.put('customerData', customerData);
  }

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
                hoverColor: Colors.blue.withOpacity(0.5),
                onLongPress: () {
                  _showDeletedialog(
                      name: data.name, room: data.room, context: context);
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
