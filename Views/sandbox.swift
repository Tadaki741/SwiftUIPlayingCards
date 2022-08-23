//
//  sandbox.swift
//  SwiftUIPlayingCards
//
//  Created by Duong Vo Dai on 23/08/2022.
//

import SwiftUI

struct ViewX: View {
    @Binding var showNestedView: Bool

    var body: some View {
        VStack{
            Text("ViewX")

            Button(action: { showNestedView = true }) {
                Text("Open ViewY")
            }

            NavigationLink(destination: ViewY(showNestedView: $showNestedView), isActive: $showNestedView) {
                EmptyView()
            }.isDetailLink(true)
        }
    }
}

struct ViewY: View {
    @Binding var showNestedView: Bool

    var body: some View {
        VStack {
            Text("ViewY")
            NavigationLink("Open ViewZ", destination: ViewZ(showNestedView: $showNestedView))
                .isDetailLink(true)
        }
    }
}

struct ViewZ: View {
    @Binding var showNestedView: Bool
    @State var showNestedView2: Bool = false

    var body: some View {
        VStack {
            Text("ViewZ")
            Button(action: { showNestedView = false}) {
                Text("Go back to ViewX")
            }

            NavigationLink("Open ViewX again", destination: ViewX(showNestedView: $showNestedView2))
                .isDetailLink(true)
        }
    }
}

struct sandbox: View {
    @State private var showNest:Bool = true;
    var body: some View {
        return ViewX(showNestedView: $showNest)
    }
}


