
import SwiftUI

struct HourCondition: View {
    
    var current : Current
    
    @EnvironmentObject var modelData : ModelData
  
    var body: some View {
            HStack {
                VStack {
                    Text(Date(timeIntervalSince1970: TimeInterval(((Int)(current.dt + modelData.forecast!.timezoneOffset ))))
                        .formatted(.dateTime.hour()))
                    Text(Date(timeIntervalSince1970: TimeInterval(((Int)(current.dt + modelData.forecast!.timezoneOffset ))))
                        .formatted(.dateTime.weekday()))
                }
                Spacer()
                AsyncImage(
                    url: URL(string: "https://openweathermap.org/img/wn/\(self.current.weather[0].icon)@2x.png"),
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
                Text("\((Int)(self.current.temp))ºC ")
                
                Text(self.current.weather[0].weatherDescription.rawValue.capitalized)
                    .foregroundColor(.black)
            } // H stack
            .padding()
        }
    }
