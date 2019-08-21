//
//  MenuListViewModel.swift
//  SwiftSideMenu
//
//  Created by on 14/2/19.
//  Copyright © 2019 Jamshed Alam. All rights reserved.
//

import UIKit

protocol MenuListViewModelDelegate: class {
    
    func modelGetMenuList(_ success:Bool,  errors: [String: String])
    
}



class MenuListViewModel: NSObject, ServiceModelDelegate {
    
    var delegate:MenuListViewModelDelegate!
    
    let sm =  ServiceModel(PostCall: false, synchronous: true)
    
    
    override init() {
        
        super.init()
    }
    
    func getMenuList() {
        
        sm.delegate = self
        sm.getMenuListFromServer()
    }
    
    func ServiceModelDidFinishTask(_ serviceModel: ServiceModel, data:ServiceData!, service:Service){
        
        var errDic = [String:String]()
        
        if data.apiResponsed {
            //This is not expected process. Server is providing data without any standered format. It returns data directly.
            if data.data != nil {
                
                var apiData = MenuListModel()
                apiData =  Mapper.getMenuList(From: data.data as? [String : AnyObject])
                
                PSUserDefaults.setMenuData(tokenId: apiData)
                delegate.modelGetMenuList(true,  errors: errDic)
            } else {
                delegate.modelGetMenuList(false,  errors: errDic)
            }
        }
        else{
            if data.timedOut == false{
                errDic["appError"] = data.appError
            }
        }
        delegate.modelGetMenuList(true ,  errors: errDic)
    }
}
