//
//  AddIndexContentView.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 28.03.2023.
//

import UIKit

class AddIndexContentView: UIView {
    
    private let cellReuseId = "IndexCheckboxCell"
    
    var onSave: (([String]) -> Void)?
    var indexVMs: [AddIndexViewModel] = []
    var filteredIndexVMs: [AddIndexViewModel] = []
    
    var selectedIndexes: [String] = []
    var searchText: String = ""
    
    private lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Найти индекс"
        bar.searchBarStyle = .minimal
        bar.backgroundImage = UIImage()
        bar.showsCancelButton = false
        bar.setSearchFieldBackgroundImage(UIImage(), for: .normal)
        if let textField = bar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = Styles.Colors.grey2
            textField.textColor = Styles.Colors.black0
            textField.clearButtonMode = .whileEditing
            textField.layer.cornerRadius = Styles.Sizes.cornerRadiusMedium
            textField.layer.masksToBounds = true
        }
        bar.delegate = self

        return bar
    }()
    
    private lazy var filterButton: IconButton = {
        let button = IconButton()
        button.setIcon(icon: Styles.Images.filter)
            .setIconSize(size: Styles.Sizes.iconBig)
            .setIconColor(color: Styles.Colors.blue1)
            .setButtonColor(color: .clear)
        
        return button
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Styles.Colors.blue1
        view.height(Styles.Sizes.separatorHeight)
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(IndexCheckboxCell.self, forCellReuseIdentifier: cellReuseId)
        tableView.rowHeight = 70
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionHeaderTopPadding = .zero
        tableView.backgroundColor = Styles.Colors.white0
        
        return tableView
    }()
    
    private lazy var saveButton: TextButton = {
        let button = TextButton()
        button.setTitle(title: "Сохранить")
            .setTitleColor(color: Styles.Colors.white0)
            .setTitleFont(font: Styles.Fonts.buttonBase)
            .setButtonColor(color: Styles.Colors.blue1)
            .setCornerRadius(radius: Styles.Sizes.cornerRadiusMedium)
        
        button.height(Styles.Sizes.buttonBase)
        button.action = { [weak self] in
            guard let self = self else { return }
            self.onSave?(self.selectedIndexes)
        }
        
        return button
    }()
    
    var saveButtonBottomConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        saveButtonBottomConstraint = NSLayoutConstraint(item: saveButton, attribute: .bottom, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: -Styles.Sizes.paddingMedium)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        saveButtonBottomConstraint = NSLayoutConstraint(item: saveButton, attribute: .bottom, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: -Styles.Sizes.paddingMedium)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(searchBar)
//        addSubview(filterButton)
        addSubview(separatorView)
        addSubview(tableView)
        addSubview(saveButton)
        
        searchBar.topToSuperview()
        searchBar.leftToSuperview(offset: Styles.Sizes.paddingSmall)
        searchBar.rightToSuperview(offset: -Styles.Sizes.paddingSmall)
//        searchBar.rightToLeft(of: filterButton, offset: Styles.Sizes.paddingMedium)
        
        
//        filterButton.height(Styles.Sizes.buttonBig)
//        filterButton.widthToHeight(of: filterButton)
//        filterButton.rightToSuperview()
//        filterButton.centerY(to: searchBar)
        
        separatorView.leftToSuperview()
        separatorView.rightToSuperview()
        separatorView.topToBottom(of: searchBar)
        
        tableView.edgesToSuperview(excluding: .top)
        tableView.topToBottom(of: separatorView)
        
        saveButton.leftToSuperview(offset:  Styles.Sizes.paddingBase)
        saveButton.rightToSuperview(offset:  -Styles.Sizes.paddingBase)
        saveButtonBottomConstraint.isActive = true
    }
    
    func setData(viewModels: [AddIndexViewModel]) {
        indexVMs = viewModels
        selectedIndexes = viewModels.filter({$0.isSelected}).map({$0.indexCode})
        
        filteredIndexVMs = viewModels
        
        tableView.reloadData()
    }

    func updateData(viewModels: [AddIndexViewModel]) {
        filteredIndexVMs = viewModels
        
        tableView.reloadData()
    }
    
    func setSaveButtonConstraint(keyboardHeight: CGFloat) {
        saveButtonBottomConstraint.constant = -keyboardHeight - Styles.Sizes.paddingMedium
        setNeedsLayout()
    }
}

extension AddIndexContentView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredIndexVMs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as! IndexCheckboxCell
        
        let vm = filteredIndexVMs[indexPath.row]
        cell.configure(vm)
        cell.onTap = { indexCode in
            if let position = self.selectedIndexes.firstIndex(where: {$0 == indexCode}) {
                self.selectedIndexes.remove(at: position)
            } else {
                self.selectedIndexes.append(indexCode)
            }
            
            print(self.selectedIndexes)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let sectionVM = sectionVMs[indexPath.section]
//        let indexVM = sectionVM.indexVMs[indexPath.row]
        
//        delegate?.didSelectIndex(index: indexVM.indexInfo)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let topOffset = scrollView.contentOffset.y
        
        if topOffset < 0 {
            searchBar.endEditing(true)
        }
    }
}
