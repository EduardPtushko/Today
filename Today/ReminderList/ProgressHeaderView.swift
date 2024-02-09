//
//  ProgressHeaderView.swift
//  Today
//
//  Created by Eduard Ptushko on 08.02.2024.
//

import SwiftUI

struct ProgressHeaderView: View {
    var progress: Double
    @State private var screenSize: CGSize = .zero
    
    var body: some View {
        VStack(spacing: 0) {
            Color(uiColor: .todayProgressUpperBackground)
                .frame(height: screenSize.width * (1 - progress))
            Color(uiColor: .todayProgressLowerBackground)
                .frame(height: screenSize.width * progress)
        }
        .clipShape(Circle())
        .overlay(
            GeometryReader { proxy in
                Color.clear.preference(key: SizePreferenceKey.self, value: proxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self) { value in
            screenSize = value
        }
    }
}

#Preview {
    ProgressHeaderView(progress: 0.4)
        .background(Color(uiColor: .todayGradientFutureBegin))
}


struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
