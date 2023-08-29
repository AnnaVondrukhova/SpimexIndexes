//
//  IndexesViewController.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 13.03.2023.
//

import UIKit
import DrawerView

class IndexesViewController: UIViewController {
    var presenter: IndexesPresenter?
    
    lazy var contentView: IndexesContentView = {
        let view = IndexesContentView()
        view.delegate = self
        view.parentVC = self
        return view
    }()
    
    let logoView: UIImageView = {
        let view = UIImageView()
        view.image = Styles.Images.spimexLogo.withRenderingMode(.alwaysOriginal)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    var currentGroup: Group?
    var currentChangingText: String = ""
    var actionToEnable: UIAlertAction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        presenter?.didLoadView()
        setupViews()
    }
    
    private func setupViews() {
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
        
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem?.title = "Изменить"
        navigationItem.rightBarButtonItem?.tintColor = Styles.Colors.white0
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        contentView.setEditing(editing, animated: true)
        
        if(self.isEditing) {
            self.editButtonItem.title = "Готово"
        } else {
            self.editButtonItem.title = "Изменить"
        }
    }
}

//presenter output
extension IndexesViewController {
    
    func setSheets(_ sheets: [SheetViewModel], selectedSheet: SheetViewModel) {
        contentView.setMenu(sheets: sheets, selectedSheet: selectedSheet)
    }
    
    func setData(viewModels: [IndexSectionViewModel]) {
        contentView.setData(viewModels: viewModels)
        navigationItem.rightBarButtonItem?.isEnabled = viewModels.count > 0
    }
}

extension IndexesViewController: IndexesContentViewDelegate {
    
    func didTapEditGroup(group: Group) {
        presenter?.editGroup(group: group)
    }
    
    func didTapDeleteGroup(group: Group) {
        presenter?.deleteGroup(group: group)
    }
    
    func didDeleteProduct(in group: Group, at index: Int) {
        presenter?.deleteProduct(in: group, at: index)
    }
    
    func didMoveProduct(in group: Group, from indexFrom: Int, to indexTo: Int) {
        presenter?.moveProduct(in: group, from: indexFrom, to: indexTo)
    }
    
    func didSelectIndex(indexVM: IndexViewModel) {
        presenter?.didTapIndexDetails(indexVM: indexVM)
    }
    
    func didTapAddProduct(in group: Group) {
        presenter?.didTapAddProduct(in: group)
    }
    
    func didTapAddGroup() {
        presenter?.addGroup()
    }
    
    func didTapEditSheets() {
        presenter?.editSheets()
    }
    
    func didTapAddSheet() {
        let alert = UIAlertController(title: "Новая подборка", message: "Введите название подборки", preferredStyle: .alert)
        alert.addTextField { tf in
            tf.placeholder = "Новая подборка"
            tf.addTarget(self, action: #selector(self.textFieldChanged(_:)), for: .editingChanged)
        }
        
        let saveAction = UIAlertAction(title: "Сохранить", style: .default, handler: { (_) in
            guard let textField = alert.textFields?[0],
                  let sheetTitle = textField.text else { return }
            
            self.presenter?.saveSheet(title: sheetTitle)
        })
        self.actionToEnable = saveAction
        saveAction.isEnabled = false
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func textFieldChanged(_ sender: Any) {
        guard let textField = sender as? UITextField else { return }
        self.actionToEnable?.isEnabled = (textField.text?.count ?? 0) > 0
    }
    
    func didSelectSheet(sheet: Sheet) {
        presenter?.didSelectSheet(sheet: sheet)
    }
}
