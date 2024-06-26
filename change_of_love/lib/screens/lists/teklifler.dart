import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OffersPage extends StatefulWidget {
  final String userId;

  const OffersPage({Key? key, required this.userId}) : super(key: key);

  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  Map<String, bool> offerStates = {};

  @override
  void initState() {
    super.initState();
    // Firestore'dan mevcut onay durumlarını al ve offerStates haritasına yükle
    loadOfferStates();
  }

  void loadOfferStates() async {
    try {
      // Firestore'dan kullanıcının tekliflerinin onay durumlarını al
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .collection('offers')
          .get();

      // Her bir teklif için onay durumunu offerStates haritasına yükle
      snapshot.docs.forEach((doc) {
        // Veriyi Map<String, dynamic> olarak doğru şekilde al
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('approved')) {
          offerStates[doc.id] = data['approved'];
        } else {
          // Belgede 'approved' alanı bulunamadı veya null
          offerStates[doc.id] = false; // Varsayılan olarak false ata
        }
      });

      // setState ile durumu güncelle
      setState(() {});
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }

  void updateOfferState(String offerId, bool approved) async {
    try {
      // Firestore'da teklifin onay durumunu güncelle
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .collection('offers')
          .doc(offerId)
          .update({'approved': approved});

      // offerStates haritasında da güncelle
      setState(() {
        offerStates[offerId] = approved;
      });
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teklifler'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userId)
            .collection('offers')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Bir hata oluştu: ${snapshot.error}'));
          }

          List<DocumentSnapshot> offerDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: offerDocs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic>? offer =
                  offerDocs[index].data() as Map<String, dynamic>?;

              if (offer == null) {
                return SizedBox(); // Eğer offer null ise, boş bir widget döndür
              }

              String offerId = offerDocs[index].id;
              bool isAccepted = offerStates[offerId] ?? false;

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(offer['offerFromUserImage']),
                ),
                title: Text(offer['offerFromUserName']),
                subtitle: Text('Kitap: ${offer['bookName']}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.check,
                          color: isAccepted ? Colors.green : null),
                      onPressed: isAccepted
                          ? null
                          : () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                        'Teklifi Onaylamak İstediğinize Emin Misiniz?'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Evet'),
                                        onPressed: () {
                                          updateOfferState(offerId, true);
                                          Navigator.of(context).pop();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Teklifi Onayladığınızı Bildirdiniz')));
                                        },
                                      ),
                                      TextButton(
                                        child: Text('Hayır'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                    ),
                    IconButton(
                      icon: Icon(Icons.close,
                          color: isAccepted ? null : Colors.red),
                      onPressed: isAccepted
                          ? () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                        'Teklifi Reddetmek İstediğinize Emin Misiniz?'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Evet'),
                                        onPressed: () {
                                          updateOfferState(offerId, false);
                                          Navigator.of(context).pop();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Teklifi Reddettiniz')));
                                        },
                                      ),
                                      TextButton(
                                        child: Text('Hayır'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          : null,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
