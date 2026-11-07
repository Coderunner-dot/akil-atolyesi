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
