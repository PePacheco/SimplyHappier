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

struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(Color.white)
            .padding()
            .frame(width: 200)
            .background(LinearGradient(gradient: Gradient(colors: [Color(hex: 0x15CDCA), Color(hex: 0x3E54D3)]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(15.0)
            .scaleEffect(configuration.isPressed ? 1.3 : 1.0)
    }
}

struct AnimatedImage: View {
    private var img: UIImage
    private var image: Image
    @State private var text: String = "Press start to preview the technique"
    
    @State private var canStart: Bool = true
    @State private var offset: CGFloat = -250
    
    init() {
        self.img = UIImage(named: "medit.png")!
        self.image = Image(uiImage: img)
    }
    
    var body: some View {
        VStack (alignment: .center) {
            ZStack {
                image
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .frame(width: 600, height: 600)

                Rectangle()
                    .frame(width: 500, height: 16)
                    .foregroundColor(Color(hex: 0x15CDCA))
                    .offset(y: offset)
                    .mask(image
                            .resizable()
                            .frame(width: 600, height: 600))
            }
            .padding(.top, 250)
            
            Button {
                if canStart {
                    self.text = "Scan your body like the picture above"
                    withAnimation(Animation.linear(duration: 20).repeatForever()) {
                        self.canStart = false
                        self.offset = offset + 480
                    }
                }
            } label: {
                HStack {
                        Image(systemName: "play")
                        Text("Start")
                    }
            }
            .buttonStyle(GradientButtonStyle())
            .padding(.bottom, 30)
            
            Text(self.text)
                .padding(.horizontal, 150)
                .foregroundColor(.white)
                .font(.system(size: 30, weight: .light))
                .lineSpacing(10)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct BackgroundView: View {
    private var img: UIImage
    private var image: Image
    private let player: Player
    var hex: UInt
    
    init(hex: UInt) {
        self.img = UIImage(named: "lotusreal.png")!
        self.image = Image(uiImage: img)
        self.hex = hex
        self.player = Player("zen3")
        self.player.play()
    }
    var body: some View {
        ZStack {
            Color(hex: hex)
                .edgesIgnoringSafeArea(.all)
            image
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.white)
                .frame(width: 200, height: 200)
                .padding(.bottom, 700)
        }
    }
}

struct CorporalScanView: View {
    var body: some View {
        ZStack {
            BackgroundView(hex: 0x3E54D3)
            AnimatedImage()
        }
    }
}

struct ContentView: View {
    var body: some View {
        CorporalScanView()
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(ContentView())

//#-end-hidden-code

/*:
 # Body Scan
 ## Improving focus using the physical sensations
 Body Scan is a meditation technique that uses the physical sensations to improve the focus while meditating.
 
 
 In order to do it, just imagine as if there was a scanner going through your body, from head to toes, and try to sense all the physical sensations of the areas being scanned.

 
 For begginers, it is advised to do this exercise in a confortable position, sitting on a chair, with your feet flat on the floor and both your hands on your lap.
 
 [Next Page](@next)
 
 */
