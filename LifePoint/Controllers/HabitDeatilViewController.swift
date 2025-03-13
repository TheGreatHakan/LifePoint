import UIKit

class HabitDetailViewController: UIViewController {
    
    // MARK: - Properties
    var habit: Habit!
    
    // MARK: - UI Components
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let frequencyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let goalLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        populateData()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .white
        title = "Habit Details"
        
        // Add ScrollView and ContentView
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Constraints for ScrollView and ContentView
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        // StackView for details
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            createSeparator(),
            createDetailRow(title: "Description:", value: descriptionLabel),
            createDetailRow(title: "Time:", value: timeLabel),
            createDetailRow(title: "Frequency:", value: frequencyLabel),
            createDetailRow(title: "Daily Goal:", value: goalLabel)
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        // Constraints for StackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func populateData() {
        titleLabel.text = habit.title
        descriptionLabel.text = habit.description ?? "No description"
        
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        timeLabel.text = timeFormatter.string(from: habit.targetTime)
        
        frequencyLabel.text = habit.frequency.rawValue
        goalLabel.text = "\(habit.goal)"
    }
    
    // MARK: - Helper Methods
    private func createSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }
    
    private func createDetailRow(title: String, value: UILabel) -> UIStackView {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, value])
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }
}
