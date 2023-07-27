
import SwiftUI

struct HourlyView: View {
    
   @EnvironmentObject var modelData: ModelData

    var body: some View {
            
        ZStack {
            Image("background")
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 140)
                .ignoresSafeArea(.container)
            
            VStack {
                    
                    Text("\(modelData.addressLocation.street), \(modelData.addressLocation.city), \(modelData.addressLocation.country)")
                        .font(.title)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 0.6)
                        .multilineTextAlignment(.center)
    
                    List {
                        
                        ForEach(modelData.forecast!.hourly) { hour in
                            HourCondition(current: hour)
                        }
                    }
                    .background(Color.clear)
                    .opacity(0.85)
            }
        }
    }
}
