//
//  CategoryViewController.swift
//  VtoU
//
//  Created by 박소희 on 2/20/24.
//

import UIKit

class CategoryViewController: UIViewController {
    
    private let category: String
    
    init(category: String) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 카테고리 페이지에 대한 UI 및 데이터 표시 로직을 구현
    }
}
