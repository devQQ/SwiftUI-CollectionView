//
//  CollectionView.swift
//  
//
//  Created by Q Trang on 7/20/20.
//

import SwiftUI
import SwiftUIToolbox

public struct CollectionView<Contents: RandomAccessCollection, Content: View>: UIViewRepresentable where Contents.Element == ContentViewModel<Content> {
    public class Coordinator: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        let parent: CollectionView
        let contents: Contents
        let removePadding: Bool
        let didSelectIndex: ((_ index: Int?) -> Void)?
        
        public init(_ parent: CollectionView, contents: Contents, removePadding: Bool, didSelectIndex: ((_ index: Int?) -> Void)?) {
            self.parent = parent
            self.contents = contents
            self.removePadding = removePadding
            self.didSelectIndex = didSelectIndex
        }
        
        public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            contents.count
        }
        
        public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(HostingCollectionCell<Content>.self)", for: indexPath) as! HostingCollectionCell<Content>
            let index = contents.index(contents.startIndex, offsetBy: indexPath.row)
            cell.removePadding = removePadding
            cell.content = contents[index].content
            
            return cell
        }
        
        public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            didSelectIndex?(indexPath.row)
        }
    }
    
    let contents: Contents
    let removePadding: Bool
    let didSelectIndex: ((_ index: Int?) -> Void)?
    
    public init(contents: Contents, removePadding: Bool, didSelectIndex: ((_ index: Int?) -> Void)? = nil) {
        self.contents = contents
        self.removePadding = removePadding
        self.didSelectIndex = didSelectIndex
    }
    
    public func makeUIView(context: Context) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(HostingCollectionCell<Content>.self, forCellWithReuseIdentifier: "\(HostingCollectionCell<Content>.self)")
        collectionView.dataSource = context.coordinator
        collectionView.delegate = context.coordinator
        
        return collectionView
    }
    
    public func updateUIView(_ uiView: UICollectionView, context: Context) {
        
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self, contents: contents, removePadding: removePadding, didSelectIndex: didSelectIndex)
    }
}

