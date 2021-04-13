//#-hidden-code


import SwiftUI
import UIKit
import PlaygroundSupport

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

struct BackgroundView: View {
    private var img: UIImage
    private var image: Image
    var hex: UInt
    init(hex: UInt) {
        self.img = UIImage(named: "lotusreal.png")!
        self.image = Image(uiImage: img)
        self.hex = hex
    }
    var body: some View {
        ZStack {
            Color(hex: hex)
            VStack {
                image
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 700)
            }
        }
    }
}


struct AnimatedShape: View {
    var sizeEnd: CGFloat = 0.0
    @State var sizeIni: CGFloat = 0.0
    @State private var rotation: Double = 0.0
    @State private var opacity: Double = 0.1
    var color: UInt = 0x00000
    private var sizeIniStored: CGFloat = 0.0
    var completion: (String) -> Void = {string in }
    
    init(sizeEnd: CGFloat, sizeIni: CGFloat, color: UInt, completion: @escaping (String) -> Void) {
        self.sizeEnd = sizeEnd
        self.sizeIni = sizeIni
        self.color = color
        self.sizeIniStored = sizeIni
        self.completion = completion
    }
    
    func exhale() {
        withAnimation(Animation.linear(duration: 8)) {
            self.sizeIni = self.sizeIniStored
            self.rotation = 0
            self.opacity = 0.1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            completion("Inhale")
            self.inhale()
        }
    }
    
    func inhale() {
        withAnimation(Animation.linear(duration: 4)) {
            self.sizeIni = sizeEnd
            self.rotation = 180
            self.opacity = 0.9
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            completion("Hold...")
            let countdown = 8
            for i in 1..<countdown {
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(i)) {
                    completion("Hold... \(i)")
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(countdown) ) {
                completion("Exhale")
                self.exhale()
            }
        }
    }
    
    var body: some View {
        Rectangle()
            .foregroundColor(Color(hex: color))
            .border(Color(hex: 0x3E54D3), width: 2)
            .frame(width: sizeIni, height: sizeIni)
            .opacity(opacity)
            .rotationEffect(.degrees(rotation), anchor: .center)
            .onAppear() {
                self.inhale()
            }
    }
}


struct AnimatedShapeView: View {
    @State private var rotation: Double = 0.0
    @State private var text: String = "Inhale"
    
    var body: some View {
        ZStack {
            ForEach(0..<12) { j in
                ForEach(0..<3) { i in
                    AnimatedShape(sizeEnd: CGFloat(350 - j*25), sizeIni: CGFloat(130 - j*10), color: i % 2 == 0 ? 0x15CDCA : 0x4F80E2) { string in
                        if j == 0 && i == 0 {
                            self.text = string
                        }
                    }
                    .rotationEffect(.degrees(Double(i) * Double(j) * 60.0))
                }
            }
            Text(self.text)
                .foregroundColor(.white)
                .font(.system(size: 50, weight: .light))
                .lineSpacing(10)
                .offset(y: 400)
                .animation(.linear)
        }
    }
}

struct BreathingView: View {
    var body: some View {
        ZStack {
            BackgroundView(hex: 0x3E54D3)
            AnimatedShapeView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        BreathingView()
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(ContentView())

//#-end-hidden-code


/*:
 
 # 4-7-8 Breathing
 
 ## Focus on your breathing

 Probably the simplest exercise of the chapter, but one of the most powerful
 
 Breathing deeply drags your focus to the breathing, stopping the process of overthinking the anxiety can cause
 
 It also reduces anxiety symptoms physiologically, making your heart rate slower and giving you a feeling of calm
 
 This technique is based on 4 seconds of inhaling, 7 seconds holding the breath and 8 seconds exhaling
 
 [Next Page](@next)
 
 */
