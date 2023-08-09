import SwiftUI

public extension View {
    func navigationFooter<Footer: View>(
        footer: @escaping () -> Footer
    ) -> some View {
        modifier(NavigationFooter(footer: footer))
    }
}

struct NavigationFooter<Footer>: ViewModifier where Footer: View {
    var footer: () -> Footer

    @State
    private var frame: CGRect = .zero

    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content
                .safeAreaInset(edge: .top) {
                    Spacer()
                        .frame(height: frame.size.height)
                }

            VStack(spacing: 0) {
                Rectangle()
                    .fill(Material.bar)
                    .frame(height: frame.origin.y + frame.size.height)
                Rectangle()
                    .fill(Color(uiColor: .separator))
                    .frame(height: 0.5)
            }
            .ignoresSafeArea()

            footer()
                .measure(with: $frame, in: .global)
        }
    }
}
