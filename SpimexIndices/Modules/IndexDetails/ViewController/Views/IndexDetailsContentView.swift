//
//  IndexDetailsContentView.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 30.03.2023.
//

import UIKit
import Charts

enum IndexPeriod: String, CaseIterable {
    case week = "7 дней"
    case month = "1 мес"
    case quarter = "3 мес"
    case year = "1 год"
    case all = "Все"
}

class IndexDetailsContentView: UIView {
    
    var onSelectPeriod: ((IndexPeriod) -> Void)? {
        didSet {
            segmentedControl.sendActions(for: .valueChanged)
        }
    }
    
    var isFirstSelection: Bool = true
    
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
        label.textColor = Styles.Colors.black0
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Styles.Fonts.subtitle
        label.textAlignment = .left
        label.textColor = Styles.Colors.grey0
        label.numberOfLines = 0
        return label
    }()
    
    private var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl()
        control.addTarget(self, action: #selector(controlIndexChanged(_:)), for: .valueChanged)
        return control
    }()
    
    private var chart: LineChartView = {
        let chart = LineChartView()
        return chart
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupSegmentedControl()
        setupChart()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setupSegmentedControl()
    }
    
    private func setupViews() {
        addSubview(dragView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(segmentedControl)
        addSubview(chart)
        
        dragView.topToSuperview(offset: Styles.Sizes.paddingBase / 2)
        dragView.centerXToSuperview()
        
        titleLabel.topToSuperview(offset: 18)
        titleLabel.leftToSuperview(offset: Styles.Sizes.paddingBase)
        titleLabel.rightToSuperview(offset: -Styles.Sizes.paddingBase)
        
        descriptionLabel.topToBottom(of: titleLabel, offset: Styles.Sizes.paddingSmall)
        descriptionLabel.leftToSuperview(offset: Styles.Sizes.paddingBase)
        descriptionLabel.rightToSuperview(offset: -Styles.Sizes.paddingBase)
        
        segmentedControl.topToBottom(of: descriptionLabel, offset: 20)
        segmentedControl.leftToSuperview(offset: Styles.Sizes.paddingBase)
        segmentedControl.rightToSuperview(offset: -Styles.Sizes.paddingBase)
        
        chart.topToBottom(of: segmentedControl, offset: 2 * Styles.Sizes.paddingMedium)
        chart.leftToSuperview(offset: Styles.Sizes.paddingBase)
        chart.rightToSuperview(offset: -Styles.Sizes.paddingBase)
        chart.height(200)
    }
    
    private func setupSegmentedControl() {
        IndexPeriod.allCases.forEach { period in
            segmentedControl.insertSegment(withTitle: period.rawValue, at: segmentedControl.numberOfSegments, animated: false)
        }
        
        segmentedControl.selectedSegmentIndex = 1
    }
    
    private func setupChart() {
        chart.rightAxis.drawLabelsEnabled = false
        chart.leftAxis.labelTextColor = Styles.Colors.black0
        chart.xAxis.labelPosition = .bottom
        chart.legend.enabled = false
    }
    
    @objc private func controlIndexChanged(_ sender: UISegmentedControl) {
        let period = IndexPeriod.allCases[sender.selectedSegmentIndex]
        
        onSelectPeriod?(period)
    }
    
    func setIndexInfo(viewModel: IndexViewModel) {
        titleLabel.text = viewModel.index?.productName
        descriptionLabel.text = viewModel.index?.name
    }
    
    func setData(viewModels: [IndexValueViewModel]) {
        let values = (0 ..< viewModels.count).map { (i) -> ChartDataEntry in
            return ChartDataEntry(x: Double(i), y: viewModels[i].indexValue)
        }
        
        let set = LineChartDataSet(entries: values)
        set.drawCirclesEnabled = true
        set.circleRadius = 4.0
        set.circleColors = [Styles.Colors.blue1]
        set.circleHoleRadius = 2.0
        set.circleHoleColor = Styles.Colors.white0
        set.drawValuesEnabled = false
        set.lineWidth = 1.0
        set.colors = [Styles.Colors.blue1]
        
        let data = LineChartData(dataSet: set)
        chart.data = data
        
        let dateStrings: [String] = viewModels.map { vm in
            let formatter = DateFormatter()
            formatter.dateFormat = "LLL dd"
            return formatter.string(from: vm.indexDate).capitalized
        }
        chart.xAxis.valueFormatter = IndexAxisValueFormatter(values: dateStrings)
    }
}
