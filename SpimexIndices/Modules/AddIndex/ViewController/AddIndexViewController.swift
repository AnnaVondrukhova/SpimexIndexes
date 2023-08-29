//
//  AddIndexViewController.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 28.03.2023.
//

import UIKit

class AddIndexViewController: UIViewController {
    
    var presenter: AddIndexPresenter?
    
    private lazy var contentView: AddIndexContentView = {
        let view = AddIndexContentView()
        view.backgroundColor = Styles.Colors.white0
        view.onSave = { [weak self] indexCodes in
            self?.presenter?.saveIndexes(indexCodes: indexCodes)
            self?.presenter?.close()
        }
        return view
    }()
    
    private let logoView: UIImageView = {
        let view = UIImageView()
        view.image = Styles.Images.spimexLogo.withRenderingMode(.alwaysOriginal)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        presenter?.didLoadView()
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(logoView)
        view.addSubview(contentView)
        
        logoView.leftToSuperview(offset: Styles.Sizes.paddingBase)
        logoView.width(124)
        logoView.height(18)
        
        contentView.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
        contentView.bottomToSuperview(usingSafeArea: false)
        
        if let navBarFrame = navigationController?.navigationBar.frame {
            logoView.bottomToTop(of: contentView, offset: -(navBarFrame.height - 18) / 2)
        }
    }
    
    private func setupNavigationBar() {
        view.backgroundColor = Styles.Colors.blue1
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(didTapClose))
        navigationItem.rightBarButtonItem?.tintColor = Styles.Colors.white0
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            contentView.setSaveButtonConstraint(keyboardHeight: keyboardSize.height - (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0))
        }
    }


    @objc func keyboardWillHide(notification: NSNotification) {
        contentView.setSaveButtonConstraint(keyboardHeight: 0)
        self.view.setNeedsLayout()
    }
    
    @objc func didTapClose() {
        presenter?.close()
    }
}

extension AddIndexViewController {
    
    func setData(viewModels: [AddIndexViewModel]) {
        contentView.setData(viewModels: viewModels)
    }
}
