//
//  Charts.swift
//  test
//
//  Created by Andrea  Ongaro on 27/03/22.
//

import SwiftUI
import Charts

struct ChartsView: View {
    var body: some View {
        
        VStack{
            Text("FOLLOW UP")
                .font(.title)
                .bold()
                .foregroundColor(Color("light_blue"))
            
            TabView{
                VStack{
                    MeasureBarChartView(entries: Measure.dataEntriesFroType("Byceps", measure: Measure.allMeasure))
                    
                    HStack(spacing: 20){
                        
                        VStack{
                            Text("BICEPS")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.black)
                            
                            Text("valore espresso in cm")
                                .foregroundColor(.black)
                                .opacity(0.45)
                        }
                        
                        
                        Image(systemName: "arrowtriangle.right")
                            .foregroundColor(.black)
                            .opacity(0.45)
                            .font(.title2)
                    }
                }
                .frame(height: 400)
                
                VStack{
                    MeasureBarChartView(entries: Measure.dataEntriesFroType("Triceps", measure: Measure.allMeasure))
                    
                    HStack(spacing: 20){
                        
                        Image(systemName: "arrowtriangle.left")
                            .foregroundColor(.black)
                            .opacity(0.45)
                            .font(.title2)
                        
                        VStack{
                            Text("TRICEPS")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.black)
                            
                            Text("valore espresso in cm")
                                .foregroundColor(.black)
                                .opacity(0.45)
                        }
                        
                        
                        Image(systemName: "arrowtriangle.right")
                            .foregroundColor(.black)
                            .opacity(0.45)
                            .font(.title2)
                    }
                }
                .frame(height: 400)
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .never))
        }
    }
}

struct Charts_Previews: PreviewProvider {
    static var previews: some View {
        ChartsView()
    }
}
