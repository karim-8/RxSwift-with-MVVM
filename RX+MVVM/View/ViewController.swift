//
//  ViewController.swift
//  RX+MVVM
//
//  Created by Karem on 8/16/20.
//  Copyright © 2020 Karem. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class ViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var itemsTableView: UITableView!
    
    
    //MARK:- Variables
    let bag = DisposeBag()
    let viewModel = ItemsViewModel()
    
    //subject to receive data from vm after binding
    private var  itemsSubjects = PublishSubject<[DataModel]>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //api cll using vm instance in the intilize of the class
        viewModel.requestData()
        //setup binding
        setupBinding()
    }
    
    func setupBinding() {
     
        //Observe over errors
        viewModel
        .error
        .observeOn(MainScheduler.instance)
        .subscribe(onNext:{ error in
            switch error {
            case .internetError(let message):
                print(message)
            case .serverMessage(let message):
                print(message)
            }
            }).disposed(by: bag)
        
        
        //Observe over Binding data
        viewModel
        .dataSubject
        .observeOn(MainScheduler.instance)
        .bind(to: self.itemsSubjects)
        .disposed(by: bag)
        
        
        //Set data in the table view cell
        itemsSubjects.bind(to: itemsTableView.rx
            .items(cellIdentifier:"cell",
                   cellType: UITableViewCell.self)){
                    (row,data,cell) in
                    cell.textLabel?.text = data.title
        }.disposed(by: bag)
    }
}

