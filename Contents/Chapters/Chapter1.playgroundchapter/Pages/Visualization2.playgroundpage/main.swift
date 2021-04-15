
/*:
 
 # Visualization
 
 ## Improving focus by bringing your feelings to the physical world
 
 The Visualization is a meditation technique that consists in visualizing a beam of energy right above your head. The main goal is to focus in what feelings this beam of energy is bringing to you.
 
 By doing that, you give your mind a little bit of space.
 
 For begginers, it is advised to start visualizing a place that you really enjoy, and feel the physical sensations of it, like the smells around you.
 
 [Next Page](@next)
 
 */


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

struct AnimatedImage: View {
    private var img: UIImage
    private var image: Image
    
    @State private var circleRadius: CGFloat = 60
    @State var isLongPressing = false
    
    init() {
        self.img = UIImage(named: "medit.png")!
        self.image = Image(uiImage: img)
    }
    
    var body: some View {
        VStack (alignment: .center) {
            ZStack {
                Circle()
                    .foregroundColor(Color(hex: 0x15CDCA))
                    .frame(height: circleRadius)
                    .offset(y: -250)
                    .blur(radius: 4.0)
                
                image
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .frame(width: 600, height: 600)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                self.circleRadius += 1
                            }

                            .onEnded { _ in
                                self.circleRadius = 60
                            }
                    )
            }
            .padding(.top, 250)
            
            Rectangle()
                .foregroundColor(Color(hex: 0x3E54D3))
                .frame(width: 100, height: 50)
                .offset(y: -62)
        }
        
    }
}

struct BackgroundView: View {
    private var img: UIImage
    private var image: Image
    var hex: UInt
    private let player: Player
    
    init(hex: UInt) {
        self.img = UIImage(named: "lotusreal.png")!
        self.image = Image(uiImage: img)
        self.hex = hex
        self.player = Player("zen6")
        self.player.play()
    }
    var body: some View {
        ZStack {
            Color(hex: hex)
                .edgesIgnoringSafeArea(.all)
            VStack {
                image
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 700)
                Text("Keep dragging your touch inside the body to focus on it and make the beam larger")
                    .foregroundColor(.white)
                    .font(.system(size: 30, weight: .light))
                    .lineSpacing(10)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 150)
            }
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
