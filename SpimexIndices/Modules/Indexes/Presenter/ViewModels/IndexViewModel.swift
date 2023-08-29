//
//  IndexViewModel.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 14.03.2023.
//

import UIKit

class IndexViewModel {
    
    var index: Index?
    var indexInfo: IndexInfo
    var titleSetting: TitleSettings = .productCode
    var subtitleSetting: SubtitleSettings = .placeName
    
    init(index: Index?, indexInfo: IndexInfo, group: Group) {
        self.index = index
        self.indexInfo = indexInfo
        self.titleSetting = group.title
        self.subtitleSetting = group.subtitle
    }
    
    var title: String {
        switch titleSetting {
        case .indexCode:
            return indexInfo.indexCode
        case .productCode:
            return indexInfo.indexProduct ?? ""
        case .productName:
            return index?.productName ?? ""
        case .placeCode:
            return index?.placeCode ?? ""
        case .placeName:
            return index?.placeName ?? ""
        }
    }
    
    var description: String {
        switch subtitleSetting {
        case .indexCode:
            return indexInfo.indexCode
        case .productCode:
            return indexInfo.indexProduct ?? ""
        case .productName:
            return index?.productName ?? ""
        case .placeCode:
            return index?.placeCode ?? ""
        case .placeName:
            return index?.placeName ?? ""
        }
    }
    
    var price: Double {
        return indexInfo.indexValue ?? 0
    }
    
    var priceChange: Double {
        if let indexValue = indexInfo.indexValue,
           indexValue != 0 {
            return (indexInfo.indexDiff ?? 0) / indexValue * 100
        } else {
            return 0
        }
    }
    
    var icon: UIImage {
        switch priceChange {
        case _ where priceChange > 0:
            return Styles.Images.arrowUpRight
        case _ where priceChange < 0:
            return Styles.Images.arrowDownRight
        default:
            return Styles.Images.arrowRight
        }
    }
}

extension IndexViewModel {
    
    var tintColor: UIColor {
        switch priceChange {
        case _ where priceChange > 0:
            return Styles.Colors.green0
        case _ where priceChange < 0:
            return Styles.Colors.red0
        default:
            return Styles.Colors.grey0
        }
    }
}
