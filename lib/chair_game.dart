import 'package:flutter/material.dart';

class ChairGame extends StatefulWidget {
  const ChairGame({Key key}) : super(key: key);

  @override
  _ChairGameState createState() => _ChairGameState();
}

class _ChairGameState extends State<ChairGame> {
  List<int> chairs = List.generate(100, (index) => index + 1);
  int skipNo = 1;
  int leaveNo = 1;
  double opacityLevel = 1.0;

  @override
  initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () => skipPerson());
  }

  skipPerson() async {
    print("chairs No=$chairs");
    while (chairs.length != 1) {
      print("Leave No=$leaveNo chairs = ${chairs.length} leaveNo = $leaveNo");
      if (leaveNo > chairs.length) {
        do {
          leaveNo = leaveNo - chairs.length;
        } while (leaveNo > chairs.length);
      }
      opacityLevel = 1.0;
      changeOppacity();
      await Future.delayed(Duration(seconds: 1, milliseconds: 500), () {
        chairs.removeAt(leaveNo - 1);
        skipNo++;
        leaveNo = leaveNo + skipNo;
        if (mounted) setState(() {});
      });
    }
    print("chairs No=$chairs");
  }

  changeOppacity() {
    setState(() {
      opacityLevel = opacityLevel == 0 ? 1.0 : 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chair Room"),
      ),
      body: chairs.length > 1
          ? GridView.count(
              crossAxisCount: 8,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              shrinkWrap: true,
              children: List.generate(
                chairs.length,
                (index) {
                  return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index == leaveNo - 1
                                ? Colors.red
                                : Color(0xFFe0f2f1)),
                        child: Center(
                            child: AnimatedOpacity(
                                opacity:
                                    index == leaveNo - 1 ? opacityLevel : 1.0,
                                duration: Duration(seconds: 1),
                                child: Text("${chairs[index]}"))),
                      ));
                },
              ),
            )
          : Center(
              child: Text(
                "Winner is Chair No ${chairs[0]}",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
      // ListView.builder(
      //     itemCount: chairs.length,
      //     itemBuilder: (listContext, index) {
      //       return Container(
      //         decoration: BoxDecoration(
      //             shape: BoxShape.circle, color: Color(0xFFe0f2f1)),
      //         child: Text("${chairs[index]}"),
      //       );
      //     }),
    );
  }
}
