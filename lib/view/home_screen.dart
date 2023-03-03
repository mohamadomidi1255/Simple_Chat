import 'package:flutter/material.dart';
import 'package:simple_chat/constant/colors.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomScreen extends StatefulWidget {
  const HomScreen({Key? key}) : super(key: key);

  @override
  State<HomScreen> createState() => _HomScreenState();
}

class _HomScreenState extends State<HomScreen> {
  List<String>? textList = [];

  var textController = TextEditingController();
  var textIpController = TextEditingController();
  String textIP = " ";
  void getIP() async {
    final ipAd = await Ipify.ipv4();
    textIP = ipAd;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.backgroundColor,
        title: Row(
          children: const [Text("Simple Chat")],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    getIP();
                  },
                  child: Container(
                    width: size.width / 4,
                    height: size.height / 13,
                    decoration: BoxDecoration(
                        color: MyColors.bottonColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(18))),
                    child: Center(
                      child: Text(
                        "دریافت IP  ",
                        style:
                            TextStyle(fontSize: 16, color: MyColors.textColor),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: size.width / 3.5),
                Text(
                  textIP.toString(),
                  style: TextStyle(color: MyColors.ipText, fontSize: 16),
                )
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    height: size.height / 12,
                    width: size.width / 4,
                    decoration: BoxDecoration(
                        color: MyColors.bottonColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(18))),
                    child: Center(
                        child: Text(
                      "اتصال",
                      style: TextStyle(fontSize: 16, color: MyColors.textColor),
                    )),
                  ),
                ),
              ),
              Container(
                  height: size.height / 15,
                  width: size.width / 1.5,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: TextField(
                    controller: textIpController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text(
                        " ادرس IP ",
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(width: 2, color: Colors.blue)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(width: 2, color: Colors.grey)),
                    ),
                  )),
            ],
          ),
          const Divider(color: Colors.black, height: 2),
          SizedBox(
              height: size.height / 1.7,
              child: textList!.length == 0
                  ? const Center(
                      child: Text(
                      "پیامی وجود ندارد",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ))
                  : ListViewChat()),
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      if (textController.text.isEmpty) {
                      } else {
                        textList?.add(textController.text);
                        textController.text = "";
                      }
                    });
                  },
                  child: Container(
                      width: size.width / 5,
                      height: size.height / 13,
                      decoration: BoxDecoration(
                          color: MyColors.bottonColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(18))),
                      child: Center(
                          child: Text(
                        "ارسال پیام",
                        style: TextStyle(color: MyColors.textColor),
                      )))),
              SizedBox(
                width: size.width / 1.4,
                height: 60,
                child: TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                    hintText: "پیام",
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(width: 2, color: Colors.blue)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(width: 2, color: Colors.grey)),
                  ),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }

  Widget ListViewChat() {
    return ListView.builder(
      itemCount: textList?.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(textList![index]),
        );
      },
    );
  }
}
