import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FollowingProfilePage extends StatelessWidget {
  final String userUid;

  const FollowingProfilePage({Key? key, required this.userUid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Takip Edilenler'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userUid)
            .collection('following')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Bir hata oluştu: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Takip edilen kullanıcı bulunamadı.'));
          }
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              // Takip edilen kullanıcı verilerini gösterme işlemi
              return ListTile(
                title: Text(doc['username']),
                // Diğer bilgileri gösterme
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
