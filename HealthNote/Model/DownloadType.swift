//
//  DownloadType.swift
//  HealthFood
//
//  Created by Apple on 2018/10/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

class DownloadType {
    
    //設計模式 Desion Pattern.
    //Singleton support
    // 這邊如果要生成一個物件 要透過shard才行。因為建構子屬性是私有的
    var type: String
    var segue: String
    var alert: Bool
    static let shared = DownloadType()
    private init(){
        type = ""
        segue = ""
        alert = true
    }
    
}

struct TypeSegue {
    let liverProtectionSegue = "LiverProtectionSegue"
    let antiFatigueSegue = "AntiFatigueSegue"
    let antiAgingSegue = "AntiAgingSegue"
    let regulateBloodLipidsSegue = "RegulateBloodLipidsSegue"
    let regulateBloodSugarSegue = "RegulateBloodSugarSegue"
    let adjustBloodPressureSegue = "AdjustBloodPressureSegue"
    let promoteIronAbsorptionSegue = "PromoteIronAbsorptionSegue"
    let boneHealthCareSegue = "BoneHealthCareSegue"
    let dentalCareSegue = "DentalCareSegue"
    let gastrointestinaImprovementSegue = "GastrointestinaImprovementSegue"
    let adjustAllergiesSegue = "AdjustAllergiesSegue"
    let immunomodulatorySegue = "ImmunomodulatorySegue"
    let notEasyToLetBodyFatSegue = "NotEasyToLetBodyFatSegue"
    let invalidCertificateSegue = "InvalidCertificatSeguee"

}
