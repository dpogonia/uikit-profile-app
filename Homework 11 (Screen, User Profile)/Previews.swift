#if canImport(SwiftUI) && DEBUG
import SwiftUI
import UIKit

struct UIViewControllerPreview<V: UIViewController>: UIViewControllerRepresentable {
    let viewController: V
    
    init(_ builder: @escaping () -> V) {
        viewController = builder()
    }
    
    func makeUIViewController(context: Context) -> V {
        viewController
    }
    
    func updateUIViewController(_ uiViewController: V, context: Context) {}
}

struct UIViewPreview<V: UIView>: UIViewRepresentable {
    let view: V
    
    init(_ builder: @escaping () -> V) {
        view = builder()
    }
    
    func makeUIView(context: Context) -> V {
        view
    }
    
    func updateUIView(_ uiView: V, context: Context) {}
}
#endif
