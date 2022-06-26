//
//  WaterAnimation.swift
//  test
//
//  Created by Andrea  Ongaro on 02/04/22.
//

import SwiftUI

struct WaterAnimation: View {
    
    @State var progress: CGFloat = 0.5
    @State var phase: CGFloat = 0.0
    @State var startAnimation: CGFloat = 0
    var id : String
    @State private var viewModel : MisurationVM = MisurationVM()
    var body: some View {
        VStack{
            Spacer()
            
            Text("Livello di Idratazione")
                .foregroundColor(Color("AccentColor"))
                .font(.title)
                .bold()
            
            Text(String(viewModel.idra))
                .foregroundColor(Color("AccentColor"))
                .font(.title)
                .bold()
            
            VStack{
                GeometryReader{proxy in
                    let size = proxy.size
                    ZStack{
                       
                        Image(systemName: "figure.wave")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                            .offset(y: -1)
                        
                        WaterWave(progress: progress, waveHeight: 0.2, offset: startAnimation)
                            .fill(.cyan)
                            .overlay(content: {
                                ZStack{
                                    Circle()
                                        .fill(.white.opacity(0.1))
                                        .frame(width: 15, height: 15)
                                        .offset(x: -20)
                                    
                                    Circle()
                                        .fill(.white.opacity(0.1))
                                        .frame(width: 15, height: 15)
                                        .offset(x: 50, y: 60)
                                }
                            })
                            .mask{
                                Image(systemName: "figure.wave")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                            .overlay(alignment: .bottom){}
                         
                    }
                    .frame(width: size.width, height: size.height, alignment: .center)
                    .onAppear{

                        withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)){
                            startAnimation = size.width - 10
                        }
                    }
                }
                .frame(height: 350)
                
                
                Spacer()
            }
            .onAppear(perform: {
                viewModel.loadHydra(idVisit: id)
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color("Secondary"))
        }
        
    }
    
}

struct WaterAnimation_Previews: PreviewProvider {
    static var previews: some View {
        WaterAnimation(id: "2")
    }
}

struct WaterWave: Shape {
    
    var progress: CGFloat
    var waveHeight: CGFloat
    var offset: CGFloat
    
    var animatableData: CGFloat{
        get{offset}
        set{offset = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in
            path.move(to: .zero)
            let progressHeight: CGFloat = (1 - progress) * rect.height
            let height = waveHeight * rect.height
            
            for value in stride(from: 0, to: rect.width, by: 2){
                
                let x: CGFloat = value
                let sine : CGFloat = sin(Angle(degrees: value + offset).radians)
                let y: CGFloat = progressHeight + (height  * sine)
                
                path.addLine(to: CGPoint(x: x, y: y))
            }
            
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x:0, y: rect.height))
        }
    }
}

struct LiquidWave: Shape {
    
    var progress: CGFloat
    var applitude: CGFloat = 10
    var waveLenght: CGFloat = 20
    var phase: CGFloat
    
    var animatableData: CGFloat{
        get{phase}
        set{phase = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        let midWidth = width / 2
        let progressHeight = height * ( 1 - progress)
        path.move(to: CGPoint(x: 0, y: progressHeight))
        
        for x in stride(from: 0, to: width + 5, by: 5){
            let relativeX = x / waveLenght
            let normalizeLenght = (x  - midWidth) / midWidth
            let y = progressHeight + sin(phase + relativeX) * applitude * normalizeLenght
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        
        return path;
    }
}
