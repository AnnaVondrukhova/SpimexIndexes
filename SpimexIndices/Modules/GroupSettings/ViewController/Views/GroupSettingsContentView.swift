//
//  GroupSettingsContentView.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 31.03.2023.
//

import UIKit

class GroupSettingsContentView: UIView {
    
    var onTapDone: ((String) -> Void)?
    var group: Group?
    var settingVMs: [GroupSettingViewModel] = []
    
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
        label.text = "Настройки группы"
        label.textAlignment = .left
        return label
    }()
    
    private lazy var doneButton: TextButton = {
        let button = TextButton()
        button.setTitle(title: "Готово")
            .setTitleColor(color: Styles.Colors.blue0)
            .setButtonColor(color: .clear)
        
        button.action = { [weak self] in
            guard let text = self?.nameTextField.text else { return }
            self?.onTapDone?(text)
        }
        button.height(Styles.Sizes.buttonBase)
        button.width("Готово".size(withAttributes: [.font : Styles.Fonts.buttonBase]).width + 2 * Styles.Sizes.paddingBase)
        return button
    }()
    
    private lazy var nameTextField: InsetTextField = {
        let textField = InsetTextField()
        textField.font = Styles.Fonts.titleRegular
        textField.textAlignment = .left
        textField.textColor = Styles.Colors.black0
        
        textField.layer.borderColor = Styles.Colors.blue1.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = Styles.Sizes.cornerRadiusMedium
        textField.addTarget(self, action: #selector(groupNameChanged), for: .editingChanged)
        return textField
    }()
    
    private lazy var tableView: IntrinsicTableView = {
        let tableView = IntrinsicTableView()
        tableView.register(GroupSettingCell.self, forCellReuseIdentifier: GroupSettingCell.cellReuseId)
        tableView.rowHeight = 44
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
        addSubview(doneButton)
        addSubview(nameTextField)
        addSubview(tableView)
        
        dragView.topToSuperview(offset: Styles.Sizes.paddingBase / 2)
        dragView.centerXToSuperview()
        
        titleLabel.topToSuperview(offset: 18)
        titleLabel.leftToSuperview(offset: Styles.Sizes.paddingBase)
        titleLabel.rightToLeft(of: doneButton)
        
        doneButton.rightToSuperview()
        doneButton.centerY(to: titleLabel)
        
        nameTextField.topToBottom(of: titleLabel, offset: 20)
        nameTextField.leftToSuperview(offset: Styles.Sizes.paddingBase)
        nameTextField.rightToSuperview(offset: -Styles.Sizes.paddingBase)
        nameTextField.height(38)
        
        tableView.leftToSuperview()
        tableView.rightToSuperview()
        tableView.topToBottom(of: nameTextField, offset: Styles.Sizes.paddingBase)
    }
    
    func configure(with group: Group?) {
        self.group = group
        
        nameTextField.text = group?.groupName ?? ""
        groupNameChanged()
    }
    
    func setData(viewModels: [GroupSettingViewModel]) {
        self.settingVMs = viewModels
        
        tableView.reloadData()
    }
    
    @objc private func groupNameChanged() {
        let text = nameTextField.text ?? ""
        
        if text.isEmpty {
            doneButton.isUserInteractionEnabled = false
            doneButton.alpha = 0.5
        } else {
            doneButton.isUserInteractionEnabled = true
            doneButton.alpha = 1.0
        }
    }
}

extension GroupSettingsContentView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingVMs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupSettingCell.cellReuseId, for: indexPath) as! GroupSettingCell
        
        let vm = settingVMs[indexPath.row]
        cell.configure(vm)

        return cell
    }
}
