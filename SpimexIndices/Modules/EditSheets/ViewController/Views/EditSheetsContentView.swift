//
//  EditSheetsContentView.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 26.04.2023.
//

import UIKit

protocol EditSheetsContentViewDelegate {
    
    func didTapEditSheet(_ sheet: Sheet)
    func didDeleteSheet(_ sheet: Sheet)
    func didTapAddSheet()
}

class EditSheetsContentView: UIView {
    
    var onTapDone: (() -> Void)?
    var delegate: EditSheetsContentViewDelegate?
    var parentVC: UIViewController?
    
    var sheetVMs: [SheetViewModel] = []
    
    private var dragView: UIView = {
        let view = UIView()
        view.backgroundColor = Styles.Colors.grey0
        view.width(36)
        view.height(5)
        view.layer.cornerRadius = 2.5
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Styles.Fonts.title
        label.text = "Управление подборками"
        label.textAlignment = .left
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Styles.Fonts.subtitle
        label.textAlignment = .left
        label.text = "Создание, изменение и удаление подборок"
        label.textColor = Styles.Colors.grey0
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var doneButton: TextButton = {
        let button = TextButton()
        button.setTitle(title: "Готово")
            .setTitleColor(color: Styles.Colors.blue0)
            .setButtonColor(color: .clear)
        
        button.action = { [weak self] in
            self?.onTapDone?()
        }
        button.height(Styles.Sizes.buttonBase)
        button.width("Готово".size(withAttributes: [.font : Styles.Fonts.buttonBase]).width + 2 * Styles.Sizes.paddingBase)
        return button
    }()
    
    private lazy var tableView: IntrinsicTableView = {
        let tableView = IntrinsicTableView()
        tableView.register(EditSheetCell.self, forCellReuseIdentifier: EditSheetCell.cellReuseId)
        tableView.rowHeight = 56
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionHeaderTopPadding = .zero
        tableView.backgroundColor = Styles.Colors.white0
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(dragView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(doneButton)
        addSubview(tableView)
        
        dragView.topToSuperview(offset: Styles.Sizes.paddingBase / 2)
        dragView.centerXToSuperview()
        
        titleLabel.topToSuperview(offset: 18)
        titleLabel.leftToSuperview(offset: Styles.Sizes.paddingBase)
        titleLabel.rightToLeft(of: doneButton)
        
        descriptionLabel.topToBottom(of: titleLabel, offset: Styles.Sizes.paddingMedium)
        descriptionLabel.leftToSuperview(offset: Styles.Sizes.paddingBase)
        descriptionLabel.rightToSuperview(offset: -Styles.Sizes.paddingBase)
        
        doneButton.rightToSuperview()
        doneButton.centerY(to: titleLabel)
        
        tableView.leftToSuperview()
        tableView.rightToSuperview()
        tableView.topToBottom(of: descriptionLabel, offset: Styles.Sizes.paddingBase)
    }
    
    func setData(viewModels: [SheetViewModel]) {
        self.sheetVMs = viewModels
        
        if viewModels.count > 1 {
            tableView.setEditing(true, animated: false)
        }
        
        tableView.reloadData()
    }

}

extension EditSheetsContentView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sheetVMs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EditSheetCell.cellReuseId, for: indexPath) as! EditSheetCell
        
        let vm = sheetVMs[indexPath.row]
        cell.configure(vm)
        cell.onTapEdit = { sheet in
            self.delegate?.didTapEditSheet(sheet)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = EditSheetFooterView()
        footerView.onTap = {
            self.delegate?.didTapAddSheet()
        }
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return Styles.Sizes.buttonBase + Styles.Sizes.paddingSmall
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if sheetVMs.count > 1 {
            return .delete
        } else {
            return .none
        }
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let deletedSheet = sheetVMs[indexPath.row].sheet
//            
//            let alert = UIAlertController(title: "Удалить подборку?", message: nil, preferredStyle: .alert)
//            let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { (_) in
//                self.sheetVMs.remove(at: indexPath.row)
//                self.delegate?.didDeleteSheet(deletedSheet)
//                
//                tableView.deleteRows(at: [indexPath], with: .automatic)
//            }
//            
//            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
//            
//            alert.addAction(cancelAction)
//            alert.addAction(deleteAction)
//            
//            self.parentVC?.present(alert, animated: true, completion: nil)
//            
//        }
//    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deletedSheet = sheetVMs[indexPath.row].sheet
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { _, _, success in
            let alert = UIAlertController(title: "Удалить подборку?", message: nil, preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { (_) in
                
                self.sheetVMs.remove(at: indexPath.row)
                self.delegate?.didDeleteSheet(deletedSheet)
                
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
            
            self.parentVC?.present(alert, animated: true, completion: nil)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}
