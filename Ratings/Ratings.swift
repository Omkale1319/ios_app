import SwiftUI
import StoreKit

struct ContentView: View {
    @Environment(\.requestReview) var requestReview
    @State private var didCoolThingsCounter = 0
    @State private var showReviewPrompt = false
    
    var body: some View {
        VStack {
            Text("\(didCoolThingsCounter)")
                .font(.system(size: 200, weight: .heavy, design: .rounded))
            Button("CircusAI") {
                didCoolThingsCounter += 1
                
                if didCoolThingsCounter == 7 {
                    requestReviewManually()
                }
            }
            .font(.system(size: 20, weight: .bold))
            .buttonStyle(.bordered)
            .controlSize(.large)
            .tint(.pink)
        }
        .padding()
        // The alert modifier should be applied here in the VStack
        .alert(isPresented: $showReviewPrompt) {
            Alert(
                title: Text("Thanks for your feedback."),
                message: Text("You can also write a review."),
                primaryButton: .default(Text("Write a Review"), action: {
                    if let url = URL(string: "https://apps.apple.com/app/id6511210590?action=write-review") {
                        UIApplication.shared.open(url)
                    }
                }),
                secondaryButton: .cancel(Text("OK"))
            )
        }
    }
    
    func requestReviewManually() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
            
            // Trigger the review prompt after the rating popup
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                showReviewPrompt = true
            }
        }
    }
}

#Preview {
    ContentView()
}
