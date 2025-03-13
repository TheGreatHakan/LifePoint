//
//  PointsView.swift
//  LifePoint
//
//  Created by HAKAN on 26.02.2025.
//

import UIKit

protocol PointsViewDelegate: AnyObject {
    
}

class PointsView: UIView {

    //MARK: - Properties
    weak var delegate: PointsViewDelegate?
    
 
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

