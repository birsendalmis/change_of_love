import 'package:flutter/material.dart';

class DeveloperAbout extends StatelessWidget {
  const DeveloperAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Geliştirici Hakkında"),
        ),
        body: const Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/images/birsen.jpeg"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Birsen DALMIŞ",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                      "   Birsen Dalmış, 3 Kasım 2000 tarihinde Osmaniye ilinin Kadirli ilçesinde 3 çocuklu bir ailenin ilk çocuğu olarak dünyaya gelmiştir.\n   İlkokul ve ortaokul eğitimini Kümbet İlköğretim Okulu’nda tamamladıktan sonra lise eğitimini Kadirli Atatürk Anadolu Lisesi’nde tamamlamıştır. Girmiş olduğu üniversite sınavı sonucunda Kahramanmaraş Sütçü İmam Üniversitesi Bilgisayar Mühendisliği bölümünü kazanmış ve 2019 yılında eğitimine başlamıştır.\n   Üniversite eğitimi süresinde yapmış olduğu stajlar sonucunda mobil uygulama geliştirme alanında kendini geliştirmeye başlamıştır ve bu alanda gelişimine devam etmektedir."),
                )
              ],
            ),
          ),
        ));
  }
}
