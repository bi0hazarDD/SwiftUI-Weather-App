

import SwiftUI

struct DailyView: View {
    
    var day : Daily
    
    @EnvironmentObject var modelData: ModelData
   
    var body: some View {
        
        HStack(alignment: .center) {
            AsyncImage(
                url: URL(string: "https://openweathermap.org/img/wn/\(self.day.weather[0].icon)@2x.png"),
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 75, maxHeight: 75)
                },
                placeholder: {
                    ProgressView()
                }
            )
            Spacer()
            VStack {
                Text(self.day.weather[0].weatherDescription.rawValue.capitalized)
                    .foregroundColor(.black)
                
                HStack {
                    Text(Date(timeIntervalSince1970: TimeInterval(((Int)(day.dt + modelData.forecast!.timezoneOffset ))))
                        .formatted(.dateTime.weekday(.wide)))
                    Text(Date(timeIntervalSince1970: TimeInterval(((Int)(day.dt + modelData.forecast!.timezoneOffset ))))
                        .formatted(.dateTime.day()))
                }
            }
            Spacer()
            Text("\((Int)(self.day.temp.max))ºC / \((Int)(self.day.temp.min))ºC")
           
        }
        .padding()
    }
}
