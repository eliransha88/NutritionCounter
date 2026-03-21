import SwiftUI

public struct DayHeaderView: View {
    public init() {}

    private var midnightSchedule: PeriodicTimelineSchedule {
        let tomorrow = Calendar.current.startOfDay(for: .now.addingTimeInterval(86400))
        return .periodic(from: tomorrow, by: 86400)
    }

    public var body: some View {
        TimelineView(midnightSchedule) { context in
            HStack {
                Text(context.date, format: .dateTime.weekday(.wide))
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.primary)
                Spacer()
            }
        }
    }
}

#Preview {
    DayHeaderView()
}
