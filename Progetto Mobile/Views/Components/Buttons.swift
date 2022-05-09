//
//  Buttons.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 05/05/22.
//

import SwiftUI

struct CustomButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .background(Color("AccentColor"))
            .cornerRadius(20)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .buttonStyle(.borderedProminent)
    }
}
