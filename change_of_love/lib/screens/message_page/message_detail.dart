import 'package:change_of_love/screens/message_page/message_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MessageDetails extends StatelessWidget {
  TextEditingController messageController = new TextEditingController();

  MessageDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 138, 173, 136),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage("assets/images/alper.jpg"),
            ),
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Alper Doruk",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  /*  Text(
                    "",
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),*/
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Icon(Icons.more_vert),
            )
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 30,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 56,
        decoration: BoxDecoration(color: Color.fromARGB(255, 247, 252, 246)),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                // mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  MyMessage(
                    myMessageText: "Merhaba Alper, nasılsın?",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  YouMessage(
                    youMessageText: "Teşekkürler iyiyim :) Sen nasılsın?",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MyMessage(
                    myMessageText: "Ben de iyiyim, teşekkürler",
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  MyMessage(
                      myMessageText:
                          "Takas listende bulunan bir kitap hakkında konuşmak için yazmıştım :)"),
                  SizedBox(
                    height: 10,
                  ),
                  YouMessage(
                    youMessageText: "Çok iyi yaptın :)",
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  YouMessage(
                    youMessageText: "Hangi kitap hakkında konuşmak istemiştin?",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MyMessage(
                      myMessageText:
                          "Dune kitabını sende istersen takas yapmak istiyorum."),
                  SizedBox(
                    height: 5,
                  ),
                  MyMessage(
                      myMessageText: "Benim kitaplarıma bir göz at istersen"),
                  SizedBox(
                    height: 5,
                  ),
                  MyMessage(
                      myMessageText: "Sana uygun bir kitap varsa ben okeyim"),
                  SizedBox(
                    height: 10,
                  ),
                  YouMessage(youMessageText: "İnceledim :)"),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Image.asset(
                              "assets/images/app_book1.jpeg",
                              height: 250,
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 130,
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 247, 252, 246),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Image.asset(
                        "assets/images/app_book1.jpeg",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  YouMessage(
                      youMessageText: "Bu kitap senin için uygun mudur?"),
                  SizedBox(
                    height: 5,
                  ),
                  YouMessage(
                      youMessageText:
                          "Aslında birkaç kitap arasında kararsız kaldım."),
                  SizedBox(
                    height: 5,
                  ),
                  YouMessage(youMessageText: "Karar verince yazsam olur mu?"),
                  SizedBox(
                    height: 10,
                  ),
                  MyMessage(myMessageText: "Olur tabii bekliyor olacağım :)"),
                  SizedBox(
                    height: 10,
                  ),
                  YouMessage(youMessageText: "Tamamdır"),
                  SizedBox(
                    height: 5,
                  ),
                  YouMessage(
                      youMessageText: "Karar verince bilgilendireceğim :)."),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            Container(
              // margin: const EdgeInsets.only(left: 20, right: 50, bottom: 0),
              alignment: Alignment.bottomCenter,
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Mesaj Yaz",
                        hintStyle: const TextStyle(color: Colors.black45),
                        suffixIcon: GestureDetector(
                            onTap: () {},
                            child: const Icon(Icons.send_rounded))),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class YouMessage extends StatelessWidget {
  final String youMessageText;
  const YouMessage({
    super.key,
    required this.youMessageText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(right: MediaQuery.of(context).size.width / 3),
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 203, 235, 255),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Text(youMessageText),
    );
  }
}

class MyMessage extends StatelessWidget {
  final String myMessageText;
  const MyMessage({
    super.key,
    required this.myMessageText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width / 2.5),
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 213, 219),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10)),
      ),
      child: Text(myMessageText),
    );
  }
}
