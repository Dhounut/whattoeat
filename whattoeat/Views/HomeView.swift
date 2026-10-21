//
//  HomeView.swift
//  whattoeat
//
//  Created by Deven Weeden (RIT Student) on 4/1/26.
//
import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing: spacing.md) {
            Text("What to Eat?")
                .font(.system(size: 44, weight: .heavy, design: .rounded))
                .foregroundStyle(colors.accent)
                .padding(.top, spacing.xl)
            Spacer()
            VStack(spacing: spacing.md) {
                HomeCard(title: "Wheel", systemImage: AppIcon.wheel) {
                    WheelView()
                }
                HomeCard(title: "Tournament", systemImage: AppIcon.tournament) {
                    TournamentView()
                }
                HomeCard(title: "Nearby", systemImage: AppIcon.nearby) {
                    NearbyView()
                }
                HomeCard(title: "Favorites", systemImage: AppIcon.favorites) {
                    FavoritesView()
                }
            }
            .padding(.horizontal, spacing.md)
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

private struct HomeCard<Destination: View>: View {
    let title: String
    let systemImage: String
    @ViewBuilder let destination: () -> Destination
    
    var body: some View {
        NavigationLink {
            destination()
        } label: {
            HStack(spacing: spacing.md) {
                Image(systemName: systemImage)
                    .font(.title)
                    .foregroundStyle(.white)
                    .frame(width: 44)
                
                Text(title)
                    .font(.title2.weight(.bold))
                    .foregroundStyle(.white)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.white.opacity(0.7))
            }
            .padding(spacing.md)
            .frame(maxWidth: .infinity)
            .background(colors.accent)
            .clipShape(RoundedRectangle(cornerRadius: radius.large))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
