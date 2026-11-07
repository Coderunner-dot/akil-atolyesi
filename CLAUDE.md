# Akıl Atölyesi

## Amaç
Farkındalık ve doğru soru sorma becerisini geliştiren kişisel bir iOS uygulaması.

## Geliştirme ortamı
- Geliştirme Windows'ta yapılıyor, Mac yok.
- Derleme yalnızca GitHub Actions'ta yapılıyor (`.github/workflows/ios-build.yml`, `macos-15`).
- Çıktı imzasız bir `.ipa`. Telefona (iPhone 11) Sideloadly ile yükleniyor.
- Ücretsiz Apple ID ile imzalandığı için uygulama 7 günde bir yeniden yüklenmeli.

## Teknik kararlar
1. SwiftUI, en düşük sürüm iOS 17.0, sadece iPhone, dikey ekran.
2. Xcode projesi elle yazılmaz: XcodeGen (`project.yml`) kullanılır. `.xcodeproj` Git'e eklenmez; GitHub Actions'ta `xcodegen generate` ile üretilir. Hedefte `scheme: {}` bulunur ki xcodebuild şemayı bulabilsin.
3. Bundle ID: `com.akilatolyesi.app`. Görünen ad: "Akıl Atölyesi".
4. Arayüz metinleri Türkçe. Kalıcı küçük veriler `@AppStorage` ile saklanır.
5. Info.plist'te `UIFileSharingEnabled` ve `LSSupportsOpeningDocumentsInPlace` açık (dışa aktarılan dosyalar Dosyalar uygulamasında görünsün).
6. İş akışı `main`'e her push'ta ve elle (`workflow_dispatch`) çalışır. Şu ayarlarla derler: `-sdk iphoneos -destination 'generic/platform=iOS' -configuration Release -derivedDataPath build CODE_SIGNING_ALLOWED=NO CODE_SIGNING_REQUIRED=NO CODE_SIGN_IDENTITY=""`. Ardından `.app` dosyasını `Payload/` içine koyup zip'leyerek `AkilAtolyesi.ipa` yapar ve `AkilAtolyesi-ipa` adıyla yükler.
7. Depo herkese açık: içinde yalnızca kod olur, kişisel veri olmaz.

## Kural
Her değişiklikten sonra GitHub Actions derlemesinin başarılı olduğunu kontrol et.

## Durum (2026-11-07)
- Aşama 1 ("Merhaba" deneme uygulaması) tamamlandı. GitHub Actions derlemesi ilk denemede başarılı oldu (run 42383357005).
- Depo: https://github.com/Coderunner-dot/akil-atolyesi (herkese açık, dal `main`).
- İndirilen .ipa: `C:\Projeler\ipa\AkilAtolyesi.ipa` (içeriği doğrulandı: `Payload/AkilAtolyesi.app`).
- GitHub hesabı: `Coderunner-dot`. Eski adı `sadettinozsevgic688-wq` idi, ikisi aynı hesap (id 308981735). `gh` içinde iki kayıt görünüyor; etkin olan `Coderunner-dot` olmalı.
- **Sıradaki adım:** Kullanıcının iPhone kablosu yolda. Kablo gelince .ipa Sideloadly ile iPhone 11'e yüklenecek: cihaza güven → Sideloadly'ye .ipa'yı sürükle, Apple ID gir, Start → iPhone'da Ayarlar > Genel > VPN ve Cihaz Yönetimi'nden geliştiriciye güven → gerekirse Gizlilik ve Güvenlik > Geliştirici Modu'nu aç.
- Yükleme çalışınca asıl uygulamanın özellikleri planlanacak.
