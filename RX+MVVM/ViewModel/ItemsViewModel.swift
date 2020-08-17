//
//  ItemsRepository.swift
//  RX+MVVM
//
//  Created by Karem on 8/17/20.
//  Copyright © 2020 Karem. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ItemViewModel {
    

    public let vmItemsSubject : PublishSubject<[DataModel]> = PublishSubject()
    let repo = ItemsRepository()
    let bag = DisposeBag()
    
    func fetchData () {
        repo.requestData()
        //Bind data
        repo
        .dataSubject
        .observeOn(MainScheduler.instance)
        .bind(to:self.vmItemsSubject)
        .disposed(by: bag)
     }
    }
