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
    let viewModel = ItemViewModel()
    let repo = ItemsRepository()
    
    //subject to receive data from vm after binding
    private var  itemsSubjects = PublishSubject<[DataModel]>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //api cll using vm instance in the intilize of the class
        viewModel.fetchData()
        //setup binding
        setupBinding()
    }
    
    func setupBinding() {
     
 
        //Adding driver instead of Observ on

        repo.error.asDriver(onErrorJustReturn: .internetError("Error"))
            .drive(onNext: { error in
            switch error {
                case .internetError(let message):
                print(message)
                case .serverMessage(let message):
                print(message)
                }
            }).disposed(by: bag)
        
        
        
        viewModel.vmItemsSubject
            .asDriver(onErrorJustReturn: [DataModel].init())
            .drive(onNext: { elements in
                print("=====\(elements)")
                self.itemsSubjects.onNext(elements)
            }).disposed(by: bag)
    
        
        
        
        

        
        //Set data in the table view cell
        itemsSubjects.bind(to: itemsTableView.rx
            .items(cellIdentifier:"cell",
                   cellType: UITableViewCell.self)){
                    (row,data,cell) in
                    cell.textLabel?.text = data.title
        }.disposed(by: bag)
    }
}

       //Observe over errors
//        repo
//        .error
//        .observeOn(MainScheduler.instance)
//        .subscribe(onNext:{ error in
//            switch error {
//            case .internetError(let message):
//                print(message)
//            case .serverMessage(let message):
//                print(message)
//            }
//            }).disposed(by: bag)


//        //Observe over Binding data
//        viewModel
//        .vmItemsSubject
//        .observeOn(MainScheduler.instance)
//        .bind(to: self.itemsSubjects)
//        .disposed(by: bag)
        
