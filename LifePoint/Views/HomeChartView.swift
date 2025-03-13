//
//  HomeChartView.swift
//  LifePoint
//
//  Created by HAKAN on 1.03.2025.
//

import UIKit

protocol HomeChartViewDelegate: AnyObject {
    func pointsDidChange()
    func didTapOnChart()
    func didLongPressOnChart()
    func didTapToDate()
}

class HomeChartView: UIView {

//    MARK: - Properties

    weak var delegate: HomeChartViewDelegate?

#warning("ChartView's background color need to be arranged by a better collor")
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let stackView: UIStackView = {
       let sv = UIStackView()
        sv.axis = .vertical
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 3
        sv.layer.borderColor = UIColor.black.cgColor
        sv.layer.borderWidth = 1
        sv.distribution = .fillProportionally
        return sv
    }()
    
    
#warning("image can be changed according to increment or decrement or constant in a time period" )
    lazy var imageView: UIImageView = {
        let config = UIImage.SymbolConfiguration(
            font: UIFont.systemFont(ofSize: 35, weight: .semibold),
            scale: .large
        )
        
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .red
        view.image = UIImage(systemName: "plus",withConfiguration: config)
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .brown
        view.layer.cornerRadius = 18
        return view
    }()
    
//   MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
//    MARK: - Functions
    
    private func setUI() {
        
        let currentDate = Date()
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "MMMM dd"
        
        let localizedDateString = dateFormatter.string(from: currentDate)
     
        let titleLabel = createLabel(name: "Points", font: UIFont.systemFont(ofSize: 22, weight: .semibold), textColor: .black)
        let pointsLabel = createLabel(name: "456", font: UIFont.systemFont(ofSize: 72, weight: .bold), textColor: .blue)
        let soFarLAbel = createLabel(name: "points earned                     ", font: UIFont.systemFont(ofSize: 18, weight: .medium), textColor: .black)
        let dateLAbel = createLabel(name: localizedDateString, font: UIFont.systemFont(ofSize: 22, weight: .semibold), textColor: .black)
        
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(pointsLabel)
        containerView.addSubview(soFarLAbel)
        containerView.addSubview(imageView)
        containerView.addSubview(dateLAbel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10),
            containerView.heightAnchor.constraint(equalToConstant: 250),
            
                
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            

            pointsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            pointsLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 10 ),
            
            soFarLAbel.topAnchor.constraint(equalTo: pointsLabel.bottomAnchor, constant: 10),
            soFarLAbel.leadingAnchor.constraint(equalTo: pointsLabel.leadingAnchor, constant: 0),
            
            imageView.leadingAnchor.constraint(equalTo: pointsLabel.trailingAnchor, constant: 10),
            imageView.topAnchor.constraint(equalTo: pointsLabel.topAnchor, constant: 20),
            
            dateLAbel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 0),
            dateLAbel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
            
        ])
    }
    
    private func createLabel(name: String, font: UIFont, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = name
        label.font = font
        label.textColor = textColor
        return label
    }

}


//#Preview {
//    HomeChartView()
//    
//}
//
