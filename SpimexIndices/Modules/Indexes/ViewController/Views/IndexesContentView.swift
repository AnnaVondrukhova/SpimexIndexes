//
//  IndexesContentView.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 14.03.2023.
//

import UIKit
import TinyConstraints

protocol IndexesContentViewDelegate {
    func didTapEditGroup(group: Group)
    func didTapDeleteGroup(group: Group)
    func didDeleteProduct(in group: Group, at index: Int)
    func didMoveProduct(in group: Group, from indexFrom: Int, to indexTo: Int)
    func didSelectIndex(indexVM: IndexViewModel)
    func didTapAddProduct(in group: Group)
    func didTapAddGroup()
    func didTapEditSheets()
    func didTapAddSheet()
    func didSelectSheet(sheet: Sheet)
}

class IndexesContentView: UIView {
    
    var delegate: IndexesContentViewDelegate?
    var parentVC: UIViewController?
    
    var sectionVMs: [IndexSectionViewModel] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(IndexInfoCell.self, forCellReuseIdentifier: IndexInfoCell.cellReuseId)
        tableView.register(NoItemsPlaceholderCell.self, forCellReuseIdentifier: NoItemsPlaceholderCell.cellReuseId)
        tableView.rowHeight = 56
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionHeaderTopPadding = .zero
        tableView.backgroundColor = Styles.Colors.white0
        
        return tableView
    }()
    
    private lazy var tableFooterView: AddGroupFooterView = {
        let footer = AddGroupFooterView(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: Styles.Sizes.buttonBase))
        
        footer.onTap = { [weak self] in
            self?.delegate?.didTapAddGroup()
        }
        
        return footer
    }()
    
    private var menuItems: [UIAction] = {
        return [ UIAction(title: "Point 1", handler: {(_) in }),
                 UIAction(title: "Point 2", handler: {(_) in }),
                 UIAction(title: "Point 3", attributes: .destructive, handler: {(_) in })]
    }()
    
    private lazy var menu: UIMenu = {
        return UIMenu(options: [], children: menuItems)
    }()
    
    private var menuButton = MenuButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        backgroundColor = Styles.Colors.white0

        addSubview(menuButton)
        addSubview(tableView)
        
        tableView.tableFooterView = tableFooterView
//        menuButton.setButtonTitle(text: "Моя подборка", enabled: true)
//        menuButton.setMenu(menu: menu)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        menuButton.topToSuperview(offset: Styles.Sizes.paddingSmall)
        menuButton.leftToSuperview()
        menuButton.height(Styles.Sizes.buttonBase)
        
        tableView.edgesToSuperview(excluding: .top)
        tableView.topToBottom(of: menuButton, offset: Styles.Sizes.paddingBase)
    }
    
    func setMenu(sheets: [SheetViewModel], selectedSheet: SheetViewModel) {
        menuButton.onSelectMenuItem = { [weak self] item in
            guard let sheetVM = item as? SheetViewModel else { return }
            self?.delegate?.didSelectSheet(sheet: sheetVM.sheet)
        }
        menuButton.onEditAction = { [weak self] in
            self?.delegate?.didTapEditSheets()
        }
        menuButton.onAddAction = { [weak self] in
            self?.delegate?.didTapAddSheet()
        }
        menuButton.setButtonTitle(text: selectedSheet.menuOptionTitle, enabled: true)
        menuButton.setMenuItems(items: sheets, selectedItem: selectedSheet, needsAdd: true)
    }
    
    func setData(viewModels: [IndexSectionViewModel]) {
        sectionVMs = viewModels
        
        tableView.reloadData()
    }
    
    func setEditing(_ editing: Bool, animated: Bool) {
        tableView.setEditing(editing, animated: true)
        tableView.tableFooterView = editing ? nil : tableFooterView
        
        menuButton.enabled = !editing
        
        tableView.reloadData()
    }
}

extension IndexesContentView: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        if sectionVMs.isEmpty {
            return 1
        } else {
            return sectionVMs.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sectionVMs.isEmpty {
            return 1
        } else if sectionVMs[section].indexVMs.isEmpty && !tableView.isEditing {
            return 1
        } else {
            return sectionVMs[section].indexVMs.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if sectionVMs.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: NoItemsPlaceholderCell.cellReuseId, for: indexPath) as? NoItemsPlaceholderCell ?? NoItemsPlaceholderCell()
            cell.configure(text: "В подборке нет добавленных групп")
            return cell
        } else if sectionVMs[indexPath.section].indexVMs.isEmpty && !tableView.isEditing {
            let cell = tableView.dequeueReusableCell(withIdentifier: NoItemsPlaceholderCell.cellReuseId, for: indexPath) as? NoItemsPlaceholderCell ?? NoItemsPlaceholderCell()
            cell.configure(text: "В группе нет добавленных индексов", topInset: Styles.Sizes.paddingBase)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: IndexInfoCell.cellReuseId, for: indexPath) as? IndexInfoCell ?? IndexInfoCell()
            
            let vm = sectionVMs[indexPath.section].indexVMs[indexPath.row]
            cell.configure(vm, isEditing: tableView.isEditing)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if sectionVMs.isEmpty {
            return nil
        }
        
        let view = IndexInfoHeaderView()
        
        view.onTapEdit = { group in
            self.delegate?.didTapEditGroup(group: group)
        }
        view.onTapDelete = { group in
            let alert = UIAlertController(title: "Удалить группу?", message: nil, preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { (_) in
                self.delegate?.didTapDeleteGroup(group: group)
                if let groupIndex = self.sectionVMs.firstIndex(where: {$0.group.groupId == group.groupId}) {
                    self.sectionVMs.remove(at: groupIndex)
                    self.tableView.reloadData()
                }
            }
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
            
            self.parentVC?.present(alert, animated: true, completion: nil)
        }
        view.configure(group: sectionVMs[section].group)
        view.setEditing(tableView.isEditing)
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if tableView.isEditing {
            let footerView = IndexInfoFooterView()
            footerView.configure(group: sectionVMs[section].group)
            footerView.onTap = { group in
                self.delegate?.didTapAddProduct(in: group)
            }
            
            return footerView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if sectionVMs.isEmpty {
            return 0
        } else {
            return Styles.Sizes.buttonBase
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if tableView.isEditing {
            return Styles.Sizes.buttonBase + Styles.Sizes.paddingSmall
        } else {
            return Styles.Sizes.paddingBase
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let group = sectionVMs[indexPath.section].group
            sectionVMs[indexPath.section].group.products.remove(at: indexPath.row)
            
            delegate?.didDeleteProduct(in: group, at: indexPath.row)
            
            sectionVMs[indexPath.section].indexVMs.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard sourceIndexPath.section == destinationIndexPath.section else { return }
        
        let rowToMove = sectionVMs[sourceIndexPath.section].indexVMs[sourceIndexPath.row]

        let group = sectionVMs[sourceIndexPath.section].group
        delegate?.didMoveProduct(in: group, from: sourceIndexPath.row, to: destinationIndexPath.row)
        
        sectionVMs[sourceIndexPath.section].indexVMs.remove(at: sourceIndexPath.row)
        sectionVMs[destinationIndexPath.section].indexVMs.insert(rowToMove, at: destinationIndexPath.row)

        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionVM = sectionVMs[indexPath.section]
        let indexVM = sectionVM.indexVMs[indexPath.row]
        
        delegate?.didSelectIndex(indexVM: indexVM)
    }
}
