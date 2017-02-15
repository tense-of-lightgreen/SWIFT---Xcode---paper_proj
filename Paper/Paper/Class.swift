//
//  Class.swift
//  Paper
//
//  Created by cscoi005 on 2017. 1. 24..
//  Copyright © 2017년 PSJ. All rights reserved.
//

import Foundation

class Paper {
    let name:String
    let author:[String]
    let institution:String
    let included:String
    let publishYear:String
    let tag:[String]
    let related:[String]
    let url:String
    
}

class Newspeed {
    let author:[String]
    let institution:String
    let tag:[String]
}

class Favorite {
    let tag:[String]
    let author:[String]
    let institution:String
    let recent:String
}

class Search {
    let category:[String]
    
}

class Folder {
    let foldername:String
    let recentedit:String
}
