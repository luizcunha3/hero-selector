//
//  ContentView.swift
//  Hero Selector
//
//  Created by Luiz Cunha on 09/11/21.
//

import SwiftUI

struct ContentView: View {
    init(viewModel: BaseHeroMainViewModel = HeroMainViewModel()) {
        self.viewModel = viewModel
    }
    
    @ObservedObject var viewModel: BaseHeroMainViewModel
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.58, green: 0.65, blue: 0.65), location: 0.3),
                
                
                
            ], center: .top, startRadius: 200, endRadius: 700).ignoresSafeArea()
            VStack {
                Text("Hero Selector")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack(spacing: 15) {
                    
                    AsyncImage(url: viewModel.getHeroImageUrl()) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }.clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 5)
                        .padding(20)
                    Text(viewModel.getHeroName())
                        .font(.largeTitle.weight(.semibold))
                }.frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Button("Another Hero") {
                    viewModel.getRandomHero()
                }.buttonStyle(.bordered)
                    .tint(Color(red: 0.1, green: 0.2, blue: 0.45))
                
            }.padding()
        }
        .onAppear(){
            viewModel.getRandomHero()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView(viewModel: MockHeroMainViewModel())
    }
}

