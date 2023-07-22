//
//  CheckmarkCartView.swift
//  CheckmarkCart
//
//  Created by Adrien Surugue on 22/07/2023.
//

import SwiftUI

struct CheckmarkCartView: View {
    
    @Environment(\.colorScheme) private var colorScheme
   
    @State private var textAnimation = false
    @State private var cartMove = false
    @State private var cartRotation = false
    @State private var cartOpacity = false
    @State private var showCheckMark: CGFloat = -100
    
    var body: some View {
        
        ZStack{
            cartIcon()
            VStack(spacing: 20){
                Spacer()
                checkMark()
                textApprouvement()
                Spacer()
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2.0)) {
                cartMove = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+2){
                withAnimation(){
                    cartRotation = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
                    withAnimation(){
                        showCheckMark = 0
                        textAnimation.toggle()
                    }
                }
            }
        }
    }
    
    func cartIcon() -> some View {
        VStack{
            Spacer()
            VStack(spacing: 20){
                Image(systemName: "cart")
                    .foregroundColor(colorScheme == .dark ? .white.opacity(0.6) : .black.opacity(0.6))
                    .font(.system(size: 180))
            }
            Spacer()
        }
        .offset(x: cartMove ? 0 : -600, y: 0)
        .rotationEffect(Angle(degrees: cartRotation ? -360 : 0))
        .opacity(cartRotation ? 0 : 1)
    }
    
    func checkMark() -> some View {
        Circle()
            .frame(width: 180, height: 180)
            .foregroundColor(.green)
            .overlay(
                Image(systemName: "checkmark")
                
                    .font(.system(size: 100))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .clipShape(Rectangle()
                        .offset(x: CGFloat(showCheckMark)))
            )
            .scaleEffect(cartRotation ? 1 : 0)
            .opacity(cartRotation ? 1 : 0)
    }
    
    func textApprouvement()-> some View {
        Text("Commande approuvée")
            .font(.title)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .opacity(textAnimation ? 1 : 0)
            .scaleEffect(textAnimation ? 1 : 6)
            .padding(.horizontal, 50)
    }
}

struct CheckmarkCartView_Previews: PreviewProvider {
    static var previews: some View {
        CheckmarkCartView()
    }
}
