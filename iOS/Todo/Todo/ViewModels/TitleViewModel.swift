//
//  TitleViewModel.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/08.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

final class TitleViewModel: ViewModelBinding {
    typealias Key = TitleModel?
    private var titleModel : Key
    private var changedHandler : (Key) -> ()
    
    init(titleModel: TitleModel, changed handler: @escaping (Key) -> () = { _ in }) {
        self.changedHandler = handler
        self.titleModel = titleModel
        changedHandler(self.titleModel)
    }
    
    func bind(changed handler: @escaping (TitleModel?) -> ()) {
        self.changedHandler = handler
        changedHandler(titleModel)
    }
}

