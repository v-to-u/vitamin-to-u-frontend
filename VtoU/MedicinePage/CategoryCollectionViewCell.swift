//
//  CategoryCollectionViewCell.swift
//  VtoU
//
//  Created by 박소희 on 2/20/24.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "CategoryCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12) // 텍스트의 폰트 크기를 작게 조정
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5 // 네모박스의 모서리 둥글기 조정
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = CGSize(width: 0, height: 1) // 그림자의 세로 길이 조정
        contentView.layer.shadowRadius = 1 // 그림자의 반경 조정
        // Label 추가
        contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize = contentView.bounds.height * 0.6 // 이미지 크기를 작게 조정
        imageView.frame = CGRect(x: (contentView.bounds.width - imageSize) / 2, y: (contentView.bounds.height - imageSize - 20) / 2, width: imageSize, height: imageSize) // 이미지 크기 및 위치 조정
        label.frame = CGRect(x: 0, y: contentView.bounds.height - 20, width: contentView.bounds.width, height: 20) // Label의 위치 조정
    }
    
    func configure(with title: String, image: UIImage?) {
        label.text = title
        imageView.image = image
    }
}
