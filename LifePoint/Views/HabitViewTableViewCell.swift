//
//  HabitViewTableViewCell.swift
//  LifePoint
//
//  Created by HAKAN on 25.02.2025.
//

import UIKit

class HabitViewTableViewCell: UITableViewCell {

        
        // MARK: - Properties
        
        static let identifier = "HabitViewCell"
        
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 18, weight: .bold)
            label.textColor = .darkText
            return label
        }()
        
        private let descriptionLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14, weight: .regular)
            label.textColor = .gray
            label.numberOfLines = 2
            return label
        }()
        
        private let frequencyLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14, weight: .medium)
            label.textColor = .systemBlue
            return label
        }()
        
        private let goalLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14, weight: .medium)
            label.textColor = .systemGreen
            return label
        }()
        
        private let stackView: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 4
            stack.distribution = .fillProportionally
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        
        // MARK: - Initializers
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Setup UI
        
        private func setupUI() {
            // Add subviews to the stack view
            stackView.addArrangedSubview(titleLabel)
            stackView.addArrangedSubview(descriptionLabel)
            stackView.addArrangedSubview(frequencyLabel)
            stackView.addArrangedSubview(goalLabel)
            
            // Add stack view to the cell's content view
            contentView.addSubview(stackView)
            
            // Set constraints for the stack view
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
                stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
            ])
        }
        
        // MARK: - Configure Cell
        
        func configure(with habit: Habit) {
            titleLabel.text = habit.title
            descriptionLabel.text = habit.description
            frequencyLabel.text = "Frequency: \(habit.frequency.rawValue)"
            goalLabel.text = "Daily Goal: \(habit.goal)"
        }
    
}
