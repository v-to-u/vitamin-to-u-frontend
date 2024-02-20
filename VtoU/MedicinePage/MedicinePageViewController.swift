//
//  MedicinePageViewController.swift
//  VtoU
//
//  Created by JungGue LEE on 2024/01/30.
//

import UIKit

class MedicinePageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let categories = ["눈", "코", "입", "간", "심장", "다리","눈", "코", "입", "간", "심장", "다리","눈", "코", "입", "간", "심장", "다리","눈", "코", "입", "간", "심장", "다리","눈", "코", "입", "간", "심장", "다리","눈", "코", "입", "간", "심장", "다리"]
    private let categoryImages = [UIImage(named: "eye"), UIImage(named: "eye"), UIImage(named: "eye"), UIImage(named: "eye"), UIImage(named: "eye"), UIImage(named: "eye"),UIImage(named: "eye"), UIImage(named: "eye"), UIImage(named: "eye"), UIImage(named: "eye"), UIImage(named: "eye"), UIImage(named: "eye"),UIImage(named: "eye"), UIImage(named: "eye"), UIImage(named: "eye"), UIImage(named: "eye"), UIImage(named: "eye"), UIImage(named: "eye"),UIImage(named: "eye"), UIImage(named: "eye"), UIImage(named: "eye"), UIImage(named: "eye"), UIImage(named: "eye"), UIImage(named: "eye"),UIImage(named: "eye"), UIImage(named: "eye"), UIImage(named: "eye"), UIImage(named: "eye"), UIImage(named: "eye"), UIImage(named: "eye"),UIImage(named: "eye"), UIImage(named: "eye"), UIImage(named: "eye"), UIImage(named: "eye"), UIImage(named: "eye"), UIImage(named: "eye")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(categoriesCollectionView)
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        
        NSLayoutConstraint.activate([
            categoriesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            categoriesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoriesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoriesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        addSearchComponents()
        addDisposalLabel()
    }
    
    private func addSearchComponents() {
        // "Find your pills" 문구 추가
        let titleLabel = UILabel()
        titleLabel.text = "Find your pills"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        // 돋보기 아이콘 추가
        let searchIconImageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        searchIconImageView.tintColor = .black
        searchIconImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchIconImageView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            searchIconImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            searchIconImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchIconImageView.widthAnchor.constraint(equalToConstant: 24),
            searchIconImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func addDisposalLabel() {
        let disposalLabel = UILabel()
        disposalLabel.text = "폐기물 처리 방법"
        disposalLabel.textColor = .white
        disposalLabel.textAlignment = .center
        disposalLabel.backgroundColor = UIColor(red: 1.0, green: 0.498, blue: 0.31, alpha: 1.0) // FF7F50
        disposalLabel.font = UIFont.systemFont(ofSize: 18)
        disposalLabel.translatesAutoresizingMaskIntoConstraints = false
        disposalLabel.layer.cornerRadius = 20
        disposalLabel.layer.masksToBounds = true
        view.addSubview(disposalLabel)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(disposalLabelTapped))
        disposalLabel.isUserInteractionEnabled = true
        disposalLabel.addGestureRecognizer(tapGesture)
        
        NSLayoutConstraint.activate([
            disposalLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            disposalLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            disposalLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            disposalLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func disposalLabelTapped() {
        guard let url = URL(string: "https://www.naver.com/") else { return }
        UIApplication.shared.open(url)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: categories[indexPath.row], image: categoryImages[indexPath.row])
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.size.width - 40) / 4 // 한 줄에 4개씩
        return CGSize(width: width, height: width)
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let selectedCategory = categories[indexPath.row]
        let categoryVC = CategoryViewController(category: selectedCategory)
        if let navigationController = navigationController {
            navigationController.pushViewController(categoryVC, animated: true)
        } else {
            print("Navigation controller is nil")
        }
    }
    @objc private func categoryLabelTapped() {
        let selectedCategory = "Selected Category"
        let categoryVC = CategoryViewController(category: selectedCategory)
        navigationController?.pushViewController(categoryVC, animated: true)
    }
    
}
