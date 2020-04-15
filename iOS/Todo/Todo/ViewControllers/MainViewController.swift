//
//  ViewController.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/06.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    private let columScrollView = ColumnScrollView()
    
    override func viewDidLoad() {
        configureScrollView()
        requestLogin { result in
            guard let result = result, result else { return }
            self.configureColumnsCase()
        }
    }
    
    private func configureScrollView() {
        view.addSubview(columScrollView)
        
        columScrollView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        columScrollView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
        columScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        columScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    
    private func requestLogin(completed: @escaping (Bool?) -> ()) {
        LoginUseCase.requestLogin(with: NetworkManager()) { result in
            completed(result)
        }
    }
   
    private func configureColumnsCase() {
        ColumnsUseCase.makeColumns(with: NetworkManager()) { columnsDataSource in
            columnsDataSource?.iterateColumns(with: { column in
                self.addColumnViewController(column: column)
            })
        }
    }
    
    private func addColumnViewController(column: Column) {
        DispatchQueue.main.async {
            let columnViewController = self.columnViewController(column: column)
            self.addChild(columnViewController)
            self.columScrollView.columnStackView.addArrangedSubview(columnViewController.view)
            columnViewController.view.translatesAutoresizingMaskIntoConstraints = false
            columnViewController.view.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.32).isActive = true
            columnViewController.view.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1).isActive = true
        }
    }
    
    private func columnViewController(column: Column) -> ColumnViewController {
        let columnViewController: ColumnViewController = {
            let controller = ColumnViewController()
            controller.configureTitleViewModel(column: column)
            controller.configureDataSource(column: column)
            controller.delegate = self
            controller.columnID = column.id
            return controller
        }()
        return columnViewController
    }
}

extension MainViewController: ColumnViewControllerDelegate {
    func columnViewControllerDidMoveToDone(_ cardViewModel: CardViewModel) {
        let doneIndex = 2
        guard let doneViewController = children[doneIndex] as? ColumnViewController else { return }
        doneViewController.addToLast(cardViewModel: cardViewModel)
    }
    
    func columnViewControllerDidMove(sourceColumnID: Int, sourceRow: Int) {
        children.forEach { viewController in
            guard let columnViewController = viewController as? ColumnViewController,
                let columnID = columnViewController.columnID,
                columnID == sourceColumnID else { return }
            columnViewController.removeCardViewModel(row: sourceRow)
        }
    }
}
