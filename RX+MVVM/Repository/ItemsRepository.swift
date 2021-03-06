//
//  ItemsViewModel.swift
//  RX+MVVM
//
//  Created by Karem on 8/16/20.
//  Copyright © 2020 Karem. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift


class ItemsRepository {
    
    //Defining Error case handling
       public enum HomeError {
           
           case internetError(String)
           case serverMessage(String)
       }
       
    
    //Definig Subjects which will get the data result from repo class
    public let dataSubject : PublishSubject<[DataModel]> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<HomeError> = PublishSubject()

    let bag = DisposeBag()
    
    
    //func to request data from Repo class 'public to be called from VC'
    public func requestData(){
        
        
        //ItemViewModel().loading.onNext(true)
        self.loading.onNext(true)
        
        APIManger.requestData(url: "albums", method: .get, parameters: nil, completion: { (result) in
        //ItemViewModel().loading.onNext(false)
        self.loading.onNext(false)
        
            //Data Mainpulation
            switch result {
                //Sucess case append data over subject
            case .success(let returnJson) :
                
                //Compact Map --> setting us map a stream's elements to optional values and then filtering out any resulting optional (nil) values in the process.
                
                //adding the all returned value as it is a array in nature
                let items = returnJson.arrayValue
                    .compactMap {
                    return DataModel(data: try! $0.rawData())}
                
                
                //ItemViewModel().dataSubject.onNext(items)
                self.dataSubject.onNext(items)
                
            case .failure(let failure) :
                switch failure {
                    
                case .connectionError:
                    //ItemViewModel().error.onNext(.internetError("Check your Internet connection."))
                    self.error.onNext(.internetError("Check your Internet connection."))
                    
                case .authorizationError(let errorJson):
                    //ItemViewModel().error.onNext(.serverMessage(errorJson["message"].stringValue))
                    self.error.onNext(.serverMessage(errorJson["message"].stringValue))
                    
                default:
                    //ItemViewModel().error.onNext(.serverMessage("Unknown Error"))
                    self.error.onNext(.serverMessage("Unknown Error"))
                }
            }
        })
    }
}
