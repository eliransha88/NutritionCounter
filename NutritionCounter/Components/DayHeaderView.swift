import SwiftUI

struct DayHeaderView: View {
    var body: some View {
        HStack {
            Text(Date.now, format: .dateTime.weekday(.wide))
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.primary)
            Spacer()
        }
    }
}

#Preview {
    DayHeaderView()
}
