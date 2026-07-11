import SwiftUI
import UIKit

struct ContentView: View {
    @State private var targetOffset = CGSize(width: 0, height: 0)
    @State private var isTracking = false
    let timer = Timer.publish(every: 0.8, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 25) {
                Text("MÔ PHỎNG ĐỊNH VỊ (ESP DEMO)")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.red, lineWidth: 1.5)
                        .background(Color.gray.opacity(0.15))
                        .frame(width: 320, height: 350)
                    
                    Circle()
                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                        .frame(width: 40, height: 40)
                    
                    VStack(spacing: 6) {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 14, height: 14)
                        Rectangle()
                            .fill(Color.green)
                            .frame(width: 50, height: 8)
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 14, height: 14)
                        Text("TARGET [15m]")
                            .font(.system(size: 9, weight: .black))
                            .foregroundColor(.white)
                            .padding(.horizontal, 4)
                            .padding(.vertical, 2)
                            .background(Color.red)
                            .cornerRadius(3)
                    }
                    .offset(targetOffset)
                    .animation(.easeInOut(duration: 0.7), value: targetOffset)
                }
                .frame(width: 320, height: 350)
                
                Button(action: {
                    isTracking.toggle()
                    if !isTracking { targetOffset = .zero }
                }) {
                    Text(isTracking ? "DỪNG BÁM ĐUỔI" : "BẮT ĐẦU BÁM ĐUỔI")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 280, height: 52)
                        .background(isTracking ? Color.red : Color.blue)
                        .cornerRadius(12)
                }
            }
        }
        .onReceive(timer) { _ in
            if isTracking {
                targetOffset = CGSize(
                    width: CGFloat.random(in: -100...100),
                    height: CGFloat.random(in: -120...120)
                )
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIHostingController(rootView: ContentView())
        self.window = window
        window.makeKeyAndVisible()
        return true
    }
}

UIApplicationMain(
    CommandLine.argc,
    CommandLine.unsafeArgv,
    nil,
    NSStringFromClass(AppDelegate.self)
