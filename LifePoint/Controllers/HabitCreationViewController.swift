import UIKit
import UserNotifications


//MARK: - a protocol to create habit
protocol HabitCreationDelegate: AnyObject {
    func didCreateHabit(_ habit: Habit)
}


class HabitCreationViewController: UIViewController {

    weak var delegate: HabitCreationDelegate?
    let lpNotification = LPNotification()
    
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
    
    private let titleTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Habit Title"
        tf.borderStyle = .roundedRect
        tf.layer.borderColor = UIColor.systemBlue.cgColor
        tf.layer.borderWidth = 1.5
        return tf
    }()
    
    private let descriptionTextView: UITextView = {
        let tv = UITextView()
        tv.layer.borderColor = UIColor.systemBlue.cgColor
        tv.layer.borderWidth = 1.5
        tv.layer.cornerRadius = 6
        tv.font = .systemFont(ofSize: 16)
        return tv
    }()
    
    private let timePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .time
        dp.preferredDatePickerStyle = .wheels
        dp.layer.borderColor = UIColor.systemBlue.cgColor
        dp.layer.borderWidth = 1.5
        return dp
    }()
    
    private let frequencyPicker: UIPickerView = {
        let pv = UIPickerView()
        pv.layer.borderWidth = 1.5
        pv.layer.borderColor = UIColor.systemBlue.cgColor
        return pv
    }()
    
    
    private let goalLabel: UILabel = {
        let label = UILabel()
        label.text = "Daily Goal: 1"
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    private let decreaseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let increaseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private let titleValidationLabel: UILabel = {
        let label = UILabel()
        label.text = "* Required"
        label.textColor = .systemRed
        label.font = .systemFont(ofSize: 12)
        label.isHidden = true
        return label
    }()
    
    private let goalValidationLabel: UILabel = {
        let label = UILabel()
        label.text = "* Goal must be at least 1"
        label.textColor = .systemRed
        label.font = .systemFont(ofSize: 12)
        label.isHidden = true
        return label
    }()
    
    
    private var goalValue: Int = 1
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        setupPickers()
        setupGoalControls()
    }
   
    // MARK: - Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground // Assuming primaryBG is similar to systemBackground
        
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
        
        // Create the goal controls stack
        let goalStack = createGoalControlStack()
        
        // Title field with validation
        let titleStack = UIStackView(arrangedSubviews: [titleTextField, titleValidationLabel])
        titleStack.axis = .vertical
        titleStack.spacing = 4
        
        // StackView for all inputs
        let stackView = UIStackView(arrangedSubviews: [
            createLabel("Title:"),
            titleStack,
            createLabel("Description:"),
            descriptionTextView,
            createLabel("Time:"),
            timePicker,
            createLabel("Frequency:"),
            frequencyPicker,
            createLabel("Daily Goal:"),
            goalStack,
            goalValidationLabel
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 90),
            frequencyPicker.heightAnchor.constraint(equalToConstant: 120),
            timePicker.heightAnchor.constraint(equalToConstant: 175)
        ])
    }
    
    private func createGoalControlStack() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [decreaseButton, goalLabel, increaseButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.alignment = .center
        
        
        NSLayoutConstraint.activate([
            decreaseButton.heightAnchor.constraint(equalToConstant: 40),
            decreaseButton.widthAnchor.constraint(equalToConstant: 40),
            increaseButton.heightAnchor.constraint(equalToConstant: 40),
            increaseButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        return stack
    }
    
    private func setupGoalControls() {
        decreaseButton.addTarget(self, action: #selector(decreaseGoal), for: .touchUpInside)
        increaseButton.addTarget(self, action: #selector(increaseGoal), for: .touchUpInside)
        updateGoalLabel()
    }
    
    @objc private func decreaseGoal() {
        if goalValue > 1 {
            goalValue -= 1
            updateGoalLabel()
        } else {
            goalValidationLabel.isHidden = false
        }
    }
    
    @objc private func increaseGoal() {
        goalValue += 1
        updateGoalLabel()
        goalValidationLabel.isHidden = true
    }
    
    private func updateGoalLabel() {
   
        goalLabel.text = "Daily Goal: \(goalValue)"
    }
    
    private func setupNavigationBar() {
        title = "New Habit"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(didTapCancel)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(didTapSave)
        )
    }
    
    private func setupPickers() {
        frequencyPicker.delegate = self
        frequencyPicker.dataSource = self
    }
    
    private func createLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }
    
    
    
    // MARK: - Actions
    
    @objc private func didTapCancel() {
        dismiss(animated: true)
    }
    
    @objc private func didTapSave() {
        var isValid = true
        
        
        guard let title = titleTextField.text, !title.isEmpty else {
            titleValidationLabel.isHidden = false
            isValid = false
            scrollToTop()
            return
        }
        
        titleValidationLabel.isHidden = true
        
        
        if goalValue < 1 {
            goalValidationLabel.isHidden = false
            isValid = false
            return
        }
        
        goalValidationLabel.isHidden = true
        
        if !isValid {
            showValidationError()
            return
        }
        
        let frequencyIndex = frequencyPicker.selectedRow(inComponent: 0)
        let frequency = HabitFrequency.allCases[frequencyIndex]
        
        switch frequency {
        case .daily: goalLabel.text = "Daily doal: "
        case .monthly: goalLabel.text = "Monthly doal: "
        case .weekly: goalLabel.text = "Weekly doal: "
        }
        
        let habit = Habit(
            title: title,
            description: descriptionTextView.text,
            targetTime: timePicker.date,
            frequency: frequency,
            goal: goalValue
        )
        
        print("Habit created: \(habit.title)")
        
        delegate?.didCreateHabit(habit)
        lpNotification.scheduleNotification(for: habit)
        dismiss(animated: true)
    }
    
    private func scrollToTop() {
        scrollView.setContentOffset(.zero, animated: true)
    }
    
    private func showValidationError() {
        let alert = UIAlertController(
            title: "Missing Information",
            message: "Please fill in all required fields",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - Picker View Data Source & Delegate
extension HabitCreationViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return HabitFrequency.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return HabitFrequency.allCases[row].rawValue
    }
}

