//
//  RSSDownloader.swift
//  HealthFood
//
//  Created by Apple on 2018/10/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

class RSSDownloader:NSObject,XMLParserDelegate {
    static var results = [HealthFoodItem]()
    private let typeData = TypeSegue()
    private var currentItem:HealthFoodItem?
    private var effectType = "", currenteElementValue:String?, currenteElementValueWhitespaces:String?
    
    private let licenseNumberTag = "許可證字號", nameTag = "中文品名", passTimeTag = "核可日期", applyCompanyTag = "申請商",
    licenseStatusTag = "證況", compositionTag = "保健功效相關成分", effectTag = "保健功效",
    effectDetailTag = "保健功效宣稱", warningTag = "警語", noticeTag = "注意事項",
    invalidCertificateTag = "失效憑證"
    
    private let liver = "護肝", fatigue = "抗疲勞", aging = "延緩衰老", bloodLipids = "調節血脂",
    bloodSugar = "調節血糖", bloodPressure = "輔助調節血壓", ironAbsorption = "促進鐵吸收",
    boneCare = "骨質保健", dentalCare = "牙齒保健", gastrointestina = "胃腸",
    allergies = "輔助調整過敏體質", immunomodulatory = "免疫調節",
    bodyFat = "不易形成體脂肪", invalidCertificate = "失效", cancellation = "註銷"
    
    
    func pass(_ parser:XMLParser){
        
        parser.delegate = self
        // 開始解析
        if parser.parse(){
//            print("Parse OK.")
            
        }else{
//            print("Parse Fail")
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "rows" {
            currentItem = HealthFoodItem()
        } else {
            currenteElementValue = nil
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if currenteElementValue == nil {
            currenteElementValue = string
        } else {
            currenteElementValue! += string.trimmingCharacters(in: .whitespacesAndNewlines)
            currenteElementValueWhitespaces = currenteElementValue?.trimmingCharacters(in: .whitespacesAndNewlines)
            //        print("else = \(String(describing: currenteElementValueWhitespaces))")
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String? ) {
        downLoadType()
        
        if effectType == invalidCertificate{
            
            downLoadInvalidCertificate(elementName)
        }else{
            
            downLoader(elementName)
        }
    }
    
    
    
    func downLoadType (){
        switch DownloadType.shared.segue {
        case typeData.liverProtectionSegue:
            effectType = liver
            break
            
        case typeData.antiFatigueSegue:
            effectType = fatigue
            break
            
        case typeData.antiAgingSegue:
            effectType = aging
            break
            
        case typeData.regulateBloodLipidsSegue:
            effectType = bloodLipids
            break
            
        case typeData.regulateBloodSugarSegue:
            effectType = bloodSugar
            break
            
        case typeData.adjustBloodPressureSegue :
            effectType = bloodPressure
            break
            
        case typeData.promoteIronAbsorptionSegue :
            effectType = ironAbsorption
            break
            
        case typeData.boneHealthCareSegue:
            effectType = boneCare
            break
            
        case typeData.dentalCareSegue:
            effectType = dentalCare
            break
            
        case typeData.gastrointestinaImprovementSegue:
            effectType = gastrointestina
            break
            
        case typeData.adjustAllergiesSegue:
            effectType = allergies
            break
            
        case typeData.immunomodulatorySegue:
            effectType = immunomodulatory
            break
            
        case typeData.notEasyToLetBodyFatSegue:
            effectType = bodyFat
            break
            
        case typeData.invalidCertificateSegue:
            effectType = invalidCertificate
            break
            
        default:
            break
        }
    }
    
    func downLoader(_ elementName : String) {
        switch elementName {
        case licenseNumberTag:
            currentItem?.licenseNumber = currenteElementValueWhitespaces
            
        case nameTag:
            currentItem?.name = currenteElementValueWhitespaces
            
        case passTimeTag:
            currentItem?.passTime = currenteElementValueWhitespaces
            
        case applyCompanyTag:
            currentItem?.applyCompany = currenteElementValueWhitespaces
            
        case licenseStatusTag:
            if currenteElementValueWhitespaces == "失效"
                || currenteElementValueWhitespaces == "註銷"{
                currentItem = nil
                return
            }else{
                currentItem?.licenseStatus = currenteElementValueWhitespaces
            }
            
        case compositionTag:
            currentItem?.composition = currenteElementValueWhitespaces
            
        case effectTag:
            if currenteElementValueWhitespaces?.range(of: effectType) != nil {
                currentItem?.effect = currenteElementValueWhitespaces
            }else{
                currentItem = nil
                return
            }
            
        case effectDetailTag:
            currentItem?.effectDetail = currenteElementValueWhitespaces
            
        case warningTag:
            currentItem?.warning = currenteElementValueWhitespaces
            
        case noticeTag:
            currentItem?.notice = currenteElementValueWhitespaces
            
        case invalidCertificateTag:
            currentItem?.invalidCertificate = currenteElementValueWhitespaces
            
        case "rows":
            // Keep currentItem in results.
            if let item = currentItem {
                //                print("Items:\(item)")
                
                RSSDownloader.results.append(item)
                
            }
            currentItem = nil
        default:
            break
        }
        currenteElementValue = nil  // Important!
    }
    
    
    func downLoadInvalidCertificate(_ elementName : String) {
        switch elementName {
        case licenseNumberTag:
            currentItem?.licenseNumber = currenteElementValueWhitespaces
            
        case nameTag:
            currentItem?.name = currenteElementValueWhitespaces
            
        case passTimeTag:
            currentItem?.passTime = currenteElementValueWhitespaces
            
        case applyCompanyTag:
            currentItem?.applyCompany = currenteElementValueWhitespaces
            
        case licenseStatusTag:
//            let aaa = currenteElementValueWhitespaces
//            print(aaa!)
            if currenteElementValueWhitespaces == "失效"
                || currenteElementValueWhitespaces == "註銷"
                || currenteElementValueWhitespaces == "併証"{
                currentItem?.licenseStatus = currenteElementValueWhitespaces
            }else{
                currentItem = nil
                return
            }
        case compositionTag:
            currentItem?.composition = currenteElementValueWhitespaces
            
        case effectTag:
            currentItem?.effect = currenteElementValueWhitespaces
            
        case effectDetailTag:
            currentItem?.effectDetail = currenteElementValueWhitespaces
            
        case warningTag:
            currentItem?.warning = currenteElementValueWhitespaces
            
        case noticeTag:
            currentItem?.notice = currenteElementValueWhitespaces
            
        case invalidCertificateTag:
            currentItem?.invalidCertificate = currenteElementValueWhitespaces
            
        case "rows":
            // Keep currentItem in results.
            if let item = currentItem {
                //                print("Items:\(item)")
               
                RSSDownloader.results.append(item)
            }
            currentItem = nil
        default:
            break
        }
        currenteElementValue = nil  // Important!
    }
}

