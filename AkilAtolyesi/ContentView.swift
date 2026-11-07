import SwiftUI

struct ContentView: View {
    // Uygulama kapatılıp açılınca da korunur.
    @AppStorage("sayac") private var sayac = 0

    var body: some View {
        VStack(spacing: 24) {
            Text("Merhaba")
                .font(.largeTitle.bold())

            Text("Akıl Atölyesi iPhone'unda çalışıyor.")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            Text("\(sayac)")
                .font(.system(size: 96, weight: .bold, design: .rounded))
                .monospacedDigit()

            Button("Bir artır") {
                sayac += 1
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
