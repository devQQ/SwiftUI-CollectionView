//
//  HostingCollectionCell.swift
//  
//
//  Created by Q Trang on 7/20/20.
//

import SwiftUI

public class HostingCollectionCell<Content: View>: UICollectionViewCell {
    private var hostingController: UIHostingController<Content>?
    public var removePadding = false
    
    public var content: Content? {
        get {
            return hostingController?.rootView
        }
        
        set {
            guard let content = newValue else { return }
            
            guard hostingController == nil else {
                hostingController?.rootView = content
                hostingController?.view.layoutSubviews()
                hostingController?.view.layoutIfNeeded()
                return
            }
            
            hostingController = UIHostingController(rootView: content)
            
            let contentView = UIView(frame: .zero)
            
            let view = hostingController!.view!
            view.translatesAutoresizingMaskIntoConstraints = false
            
            contentView.addSubview(view)
            
            NSLayoutConstraint.activate([view.leftAnchor.constraint(equalTo: contentView.leftAnchor),
                                         view.rightAnchor.constraint(equalTo: contentView.rightAnchor),
                                         view.topAnchor.constraint(equalTo: contentView.topAnchor),
                                         view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)])
            
            
            contentView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(contentView)
            
            if removePadding {
                NSLayoutConstraint.activate([contentView.leftAnchor.constraint(equalTo: leftAnchor),
                                             contentView.rightAnchor.constraint(equalTo: rightAnchor),
                                             contentView.topAnchor.constraint(equalTo: topAnchor),
                                             contentView.bottomAnchor.constraint(equalTo: bottomAnchor)])
            } else {
                NSLayoutConstraint.activate([contentView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
                                             contentView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
                                             contentView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
                                             contentView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)])
            }
        }
    }
}

