import 'package:flutter/material.dart';

class CofAbout extends StatelessWidget {
  const CofAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Of Love Hakkında"),
      ),
      body: const Expanded(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "Change Of Love",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                  "   Change of Love uygulaması (CoL), kitap alıp okumanın zorlaştığı bu dönemde kitap severlerin kurtarıcısı olmayı hedefliyor.\n   CoL sayesinde kullanıcılar güvenli ve oldukça kolay bir şekilde birbirleri ile kitap takası gerçekleştirebilecek ve böylece büyük paralar ödemeden çokça kitap okuma fırsatı edinmiş olacaklar.\n   Projede kullanıcıların birbirleriyle iletişim kurabilecekleri mesajlaşma ortamı, kitaplarını yükleyebilecekleri kütüphane alanı, elinde olmayan ancak okumak istediği kitapları listeleyebilecekleri ‘okumak istediklerim’ alanı, daha önceden gerçekleştirdiği bir takas işlemi var ise bunun yer alacağı ‘takas ettikleri’ alanı, iletişimde olmak istediği kullanıcıları takibe alabilme imkanı, beğendiği bir kitaba takas teklifinde bulunabilme imkanı gibi detaylar yer almaktadır.\n   CoL uygulaması ilerleyen süreçte yalnızca takas işlemi değil aynı zamanda kullanıcıların kitaplarını satabileceği bir yer haline gelmeyi hedefliyor.\n   CoL’un ilk önceliği aynı veya yakın bölgede bulunan kullanıcıların iletim ücreti olmadan birebir takas işlemi gerçekleştirmesini sağlamaktır. İlerleyen süreçte şehirlerarası takası da mümkün hale getirmek için çalışmalar gerçekleştirilecektir.\n   Uygulamaya giriş yapmak için öncesinde bazı bilgiler girilerek kayıt işlemi gerçekleştirilmeli ardından giriş yap sayfasından kullanıcı girişi sağlanmalıdır.\n   Kullanıcıların uygulama şifrelerini unutmaları durumunda şifremi unuttum sayfasından gerekli işlemleri gerçekleştirip yeni şifre talebinde bulunmaları gerekir. Talep sonucu onlara iletilen kodu ilgili kısma girerek yeni şifre oluşturabilirler.\n   Kullanıcı uygulamaya giriş yaptıktan sonra onu anasayfa ekranı karşılayacaktır. Anasayfa da kullanıcının etkileşimde olduğu diğer kullanıcıların paylaşımları yer almaktadır.\n   Kullanıcının diğer kullanıcılara erişim sağlayabilmesi için arama sayfası da mevcuttur. Kullanıcılar bu sayfa sayesinde istedikleri kitabı veya başka bir kullanıcıyı rahatça arama işlemi yaparak ulaşım sağlayabilir.\n   Uygulamada kullanıcının kütüphanesi, okumak istedikleri listesi, takas etmek istedikleri listesi yer almakta ve bunlara ekleme/düzenleme yapma özelliği bulunmaktadır.\n   Uygulama içerisinde kullanıcıların iletişim kurmasını sağlamak amaçlı mesajlaşma özelliği mevcuttur. Kullanıcılar diğer kullanıcıların gönderilerine takas talebi gönderebilecekleri gibi dilerlerse mesajlaşma özelliği ile takasın ayrıntılarını konuşabilirler.\n   CoL uygulamasında kullanıcının kütüphanesi, okumak istedikleri gibi bilgilerin yanı sıra fotoğrafı ve profilinde görünmesini isteyeceği bazı kişisel bilgilerin (meslek, memleket, doğum tarihi…) yer aldığı profil sayfası mevcuttur.\n   Bir kullanıcı diğer kullanıcıların gönderilerini beğenebilir, kullanıcıyı veya gönderiyi değerlendirebilir, gönderiye yorum yapabilir, gönderi için takas teklifinde bulunabilir, kendi yüklediği gönderisine açıklama yazabilir, diğer kullanıcıları takibe alabilir, takipten çıkarabilir vb. imkanlara sahiptir."),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
