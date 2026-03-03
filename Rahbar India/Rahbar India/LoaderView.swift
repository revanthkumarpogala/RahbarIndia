//
//  LoaderView.swift
//  Rahbar India
//
//  Created by revanth kumar on 03/03/26.
//

import Foundation

import UIKit

final class LoaderView {
    
    static let shared = LoaderView()
    private var loaderView: UIView?
    
    private init() {}
    
    private func getKeyWindow() -> UIWindow? {
        return UIApplication.shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }
    
    func show() {
        if loaderView != nil { return }
        guard let window = getKeyWindow() else { return }
        
        let bgView = UIView(frame: window.bounds)
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        activityIndicator.color = .white
        
        bgView.addSubview(activityIndicator)
        window.addSubview(bgView)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: bgView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: bgView.centerYAnchor)
        ])
        
        loaderView = bgView
    }
    
    func hide() {
        loaderView?.removeFromSuperview()
        loaderView = nil
    }
}
