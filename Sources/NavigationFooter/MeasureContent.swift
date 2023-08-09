import SwiftUI

extension View {
    func measure(
        with frame: Binding<CGRect>,
        in coordinateSpace: CoordinateSpace
    ) -> some View {
        modifier(MeasureContent(frame: frame, coordinateSpace: coordinateSpace))
    }
}

struct MeasureContent: ViewModifier {
    @Binding
    var frame: CGRect

    var coordinateSpace: CoordinateSpace

    func body(content: Content) -> some View {
        content
        .background(
            GeometryReader { content in
                Color.clear
                    .onAppear {
                        self.frame = content.frame(in: coordinateSpace)
                    }
                    .onChange(of: content.frame(in: coordinateSpace)) { frame in
                        self.frame = frame
                    }
            }
        )
    }
}
