//
//  ViewController.swift
//  LifePoint
//
//  Created by HAKAN on 8.02.2025.
//

import UIKit

class HabitTrackingViewController: UIViewController {
    
//    MARK: - properties
    
    private var habits = [Habit]()
    

    
    private let tview: UITableView = {
       let view = UITableView(frame: .zero, style: .plain)
        view.register(HabitViewTableViewCell.self, forCellReuseIdentifier: HabitViewTableViewCell.identifier)
        return view
    }()

    private let textView: UITextView = {
        let tv = UITextView()
        tv.text = "To add a habit, tap the plus (+) button in the top right corner of the screen and fill out the form."
        tv.font = .systemFont(ofSize: 18)
        tv.textColor = .gray
        tv.textAlignment = .center
        tv.isSelectable = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
//    MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
        
        if habits.isEmpty {
            let vc = UINavigationController(rootViewController: HabitCreationViewController())
            vc.modalPresentationStyle = .fullScreen
        }
        
        setUpUI()
    }
    
    
//    MARK: - functions
    
    
#warning("habits array needs to store in local")
    override func viewDidLayoutSubviews() {
        if habits.isEmpty {
            textView.frame = view.frame
        } else {
            tview.frame = view.frame
        }
        
    }
    
    @objc private func handleAdd() {
        let vc = HabitCreationViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
        
    }

    private func updateViewsVisibility() {
        if habits.isEmpty {
            textView.isHidden = false
            tview.isHidden = true
        } else {
            textView.isHidden = true
            tview.isHidden = false
        }
    
    }
    
    private func setUpUI() {
    
        view.addSubview(textView)
        view.addSubview(tview)
        
        
        tview.delegate = self
        tview.dataSource = self
        
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        
        tview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tview.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
        updateViewsVisibility()
    }
  
}

// MARK: - Table View delegates and data source
extension HabitTrackingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Number of habits: \(habits.count)")
        return habits.count
    }
    
    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          guard let cell = tableView.dequeueReusableCell(withIdentifier: HabitViewTableViewCell.identifier, for: indexPath) as? HabitViewTableViewCell else {
              return UITableViewCell()
          }
          cell.configure(with: habits[indexPath.row])
 
          return cell
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let habit = habits[indexPath.row]
        let detailVC = HabitDetailViewController()
        detailVC.habit = habit // Pass the selected habit
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - HabitCreation Delegate

extension HabitTrackingViewController: HabitCreationDelegate {
    func didCreateHabit(_ habit: Habit) {
        print("Received Habit: \(habit.title)")
              habits.append(habit)
              DispatchQueue.main.async {
                  self.tview.reloadData()
                  self.updateViewsVisibility()
                  print("Habit received: \(habit.title)")
              }
    }
    
    
}


