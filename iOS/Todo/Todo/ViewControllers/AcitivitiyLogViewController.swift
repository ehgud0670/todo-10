//
//  AcitivitiyLogViewController.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/06.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class AcitivitiyLogViewController: UITableViewController {
    private var logViewModels: LogViewModels?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureObserver()
        configureView()
        configureLogsCase()
    }
    
    private func configureTableView() {
        tableView.register(LogCell.self, forCellReuseIdentifier: LogCell.reuseIdentifier)
        tableView.dataSource = self
    }
    
    private func configureObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateView),
                                               name: LogViewModels.Notification.logViewModelsDidChange,
                                               object: logViewModels)
    }
    
    @objc private func updateView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func configureView() {
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 0.8
        view.layer.borderColor = UIColor.opaqueSeparator.cgColor
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
    }
    
    private func configureLogsCase() {
        LogsUseCase.makeLogs(with: MockLogsSuccessStub()) { logViewModels in
            guard let logViewModels = logViewModels else { return }
            self.logViewModels = logViewModels
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let logViewModels = logViewModels else { return  0 }
        return logViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let logCell = tableView.dequeueReusableCell(withIdentifier: LogCell.reuseIdentifier) as? LogCell,
            let logViewModels = logViewModels,
            let logViewModel = logViewModels.logViewModel(at: indexPath.row) else { return LogCell() }
            logViewModel.performBind(changed: { log in
                logCell.configureLogContent(text: log.content)
            })
        return logCell
    }
}
