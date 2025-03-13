//
//  HomeViewController.swift
//  LifePoint
//
//  Created by HAKAN on 26.02.2025.
//


#warning("user can choose background colors but once it a componenet's bg selected others can be advised as colorpedia to user")
import UIKit

class HomeViewController: UIViewController {
    
//    MARK: - Properties
    lazy var homeChartView: HomeChartView = {
        let view = HomeChartView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.containerView.backgroundColor = .orange
        return view
    }()
    
    private let segmentedView: UISegmentedControl = {
        let sv = UISegmentedControl(items: ["1", "2", "3"])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.selectedSegmentIndex = 0
        sv.tintColor = .systemBlue
        return sv
    }()
    
    private let tview: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tv
    }()
    
//MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        
    }
    

//   MARK: - funtions
    
    
    
    private func setUI() {
        
        view.addSubview(homeChartView)
        homeChartView.delegate = self
        view.addSubview(segmentedView)
        view.addSubview(tview)
        
        tview.delegate = self
        tview.dataSource = self
        
        segmentedView.addTarget(
            self,
            action: #selector(segmentChanged),
            for: .valueChanged
        )
        
        NSLayoutConstraint.activate([
            homeChartView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 0),
            homeChartView.widthAnchor.constraint(equalToConstant: view.frame.maxX - 30),
            homeChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            homeChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            segmentedView.topAnchor.constraint(equalTo: homeChartView.bottomAnchor, constant: 20),
            segmentedView.leadingAnchor.constraint(equalTo: homeChartView.leadingAnchor, constant: 0),
            segmentedView.trailingAnchor.constraint(equalTo: homeChartView.trailingAnchor, constant: 0),
            
            tview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tview.topAnchor.constraint(equalTo: segmentedView.bottomAnchor, constant: 10),
            tview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            
            
        ])
    }

    @objc private func segmentChanged() {
            tview.reloadData()
        }
}


extension HomeViewController: HomeChartViewDelegate {
    func pointsDidChange() {
        
    }
    
    func didTapOnChart() {
        
    }
    
    func didLongPressOnChart() {
        
    }
    
    func didTapToDate() {
        
    }
    
}



extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = 0
        
        switch segmentedView.selectedSegmentIndex {
        case 1: return 5
        case 0: return 3
        case 2: return 7
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    
}

