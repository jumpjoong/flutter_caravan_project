import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class DailyStatus extends StatefulWidget {
  const DailyStatus({super.key});

  @override
  State<DailyStatus> createState() => _DailyStatusState();
}

class _DailyStatusState extends State<DailyStatus> {
  late TextEditingController _name;
  Map<String, List<String>> caravanRoomList = {
    '100동 라인': ['101동', '102동', '103동', '104동'],
    '200동 라인': ['201동', '202동', '203동', '204동', '205동'],
    '300동 라인': ['301동', '302동', '303동', '304동', '305동'],
    'VIP': ['VIP'],
  };

  void addHiveBox(String room) async {
    // 이름
    String name = _name.text;
    // 박스 열기
    Box box = Hive.box('caravanCustomer');
    List customerData = List.from(box.get('customerData', defaultValue: [])!);
    customerData.add({'name': name, 'room': room});
    await box.put('customerData', customerData);
  }

  //팝업창
  _showdialog(BuildContext context, String room) {
    String customorName = _name.text;

    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('확인창'),
        content: Text('$customorName님 $room 맞습니까?'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('취소'),
          ),
          ElevatedButton(
            onPressed: () => {
              addHiveBox(room),
              //팝업창 닫기
              Navigator.of(context).pop(),
              setState(() {
                _name.clear();
              })
            },
            child: Text('확인'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _name.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('객실 일일 현황 작성하기'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8),
            child: Text('성함 작성'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 10),
            child: SizedBox(
              width: 150,
              height: 40,
              child: TextField(
                controller: _name,
                onChanged: (value) {
                  setState(() {});
                },
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(left: 8),
                ),
              ),
            ),
          ),
          Expanded(
            child: _name.text.isEmpty
                ? Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text('이름을 입력하면 동이 나와용~'),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: caravanRoomList.entries.map((title) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // 카테고리 제목
                            Text(
                              title.key,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            // 카테고리 항목들
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: title.value.map((room) {
                                return InkWell(
                                  onTap: () {
                                    _showdialog(context, room);
                                  },
                                  child: Card(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          room,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 16),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
