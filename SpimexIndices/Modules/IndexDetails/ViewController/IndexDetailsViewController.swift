//
//  IndexDetailsViewController.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 23.03.2023.
//

import UIKit
import DrawerView

class IndexDetailsViewController: UIViewController {
    
    var presenter: IndexDetailsPresenter?
    
    var contentView = IndexDetailsContentView() 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.didLoadView()
    }
    
}

// Presenter output
extension IndexDetailsViewController {
    
    func setupViews() {
        
        setupDrawerView()
        contentView.onSelectPeriod = { [weak self] period in
            self?.presenter?.didSelectPeriod(period)
        }
        
    }
    
    func setIndex(viewModel: IndexViewModel) {
        contentView.setIndexInfo(viewModel: viewModel)
    }
    
    func setData(viewModels: [IndexValueViewModel]) {
        contentView.setData(viewModels: viewModels)
    }
}
