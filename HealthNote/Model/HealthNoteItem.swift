//
//  HealthFoodItem.swift
//  HealthFood
//
//  Created by Apple on 2018/10/17.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

class HealthFoodItem: Codable {
    var licenseNumber:String?
    var name:String?
    var passTime:String?
    var applyCompany: String?
    var licenseStatus:String?
    var composition: String?
    var effect: String?
    var effectDetail: String?
    var warning: String?
    var notice: String?
    var invalidCertificate: String?
    var title:String?
    var note:String?
    
    private static var fileURL : URL {
        var documentDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        //存在emojis.plist的地方
        documentDir.appendPathComponent("HealthFoodItem")
        documentDir.appendPathExtension("plist")
//        print("fileURL: \(documentDir.absoluteString)")
        return documentDir
        
    }
    //存檔
    static func sava(_ healthFoodItem:[HealthFoodItem]){
        //取得編碼器
        let encoder = PropertyListEncoder()
   
        if let encodedHealthFood = try?
            encoder.encode(healthFoodItem){
            try! encodedHealthFood.write(to: fileURL)
//            print("save")
        }
    }
    
    //讀檔
    static func load() -> [HealthFoodItem]?{
        let decoder = PropertyListDecoder()
        if let decodedHealthFood = try? Data(contentsOf: fileURL){
            let result = try? decoder.decode(Array<HealthFoodItem>.self, from: decodedHealthFood)
//            print("load")
            return result
        }
        return nil
    }
  
}



struct EvaluationCriteria {
    let evaluationCriteria = ["GastrointestinaImprovementSegue": "\t食品種類繁多，其中部份食品可改善食慾，促進消化酵素的分泌，增進胃腸蠕動，增加小腸吸收。食品亦可因含有利腸道益生菌生長的成份，或本身含有腸道中的有益細菌，因而具改善腸內菌相的功能。\n\n\t因此，若食品具有下列任一種功能時，可認為具有改善胃腸道功能。\n(1) 促進消化吸收。\n(2) 改善腸內細菌菌相。\n(3) 幫助(改善)胃腸運動。\n(4) 有助於胃黏膜之保護作用。\n(5) 減少胃內幽門螺瘤桿菌。",
                                                       "BoneHealthCareSegue": "\t本評估方法除可採信人體試驗以「骨密度」作為主要依據之指標外，也認可「骨代謝生化指標」是能評估受試食品對骨質影響功效的更敏感又可靠之指標。\n\n\t停經後婦女或進行卵巢切除之動物模式，骨代謝指標得以OC活性為主要指標；而青少年或成長期動物試驗則以OB活性為主要指標。\n\n\t人體實驗得選擇下列「鈣質生物利用率測定」或「骨質變化測定」之一即可，能同時進行兩者更佳。",
                                                       "LiverProtectionSegue": "\t國人肝臟疾病罹患率甚高，慢性肝病及肝硬化為十大死亡原因之第六位，每年死亡人數在三千人以上。\n\n\t造成肝臟疾病之主要因素有病毒性、酒精性與化學性三大類，而在老鼠動物模式之病理切片中與人體有一致之病理現象者為化學性肝損傷。\n\n\t由於造成病毒性、酒精性肝損傷之動物模式不易建立，因此本評估方法僅針對化學性肝損傷進行護肝功能之評估。所以本評估方法之進行主要是以四氯化碳誘導大(小)白鼠慢性肝損傷的實驗模式，探討不同試驗樣品之處理對於大(小)白鼠慢性肝損傷之影響。四氯化碳誘導肝損傷之原理，主要是因四氯化碳受肝微粒酵素活化成三氯甲烷自由基，然後與蛋白質結合導致蛋白質合成受阻，並引起脂質分解代謝失調，引起肝細胞內三酸甘油酯蓄積，另外三氯甲烷自由基形成過氧化物，導致脂質過氧化而使得肝細胞膜損傷，造成肝中酵素森慎滲出及細胞病變而壞死。\n\n\t本評估方法將於日後再予以適當增加肝功能評估項目，以加強肝功能評估之完整性。另外，本評估方法目前僅針對化學性肝損傷進行護肝功能之評估，未來陸續將病毒性、酒精性肝損傷護肝功能之評估方法納入。",
                                                       "AntiFatigueSegue": "\t疲勞是指身體無法維持在一定水平上運作，各器官也不能保持固定的工作能力；及身體因過度活動而造成作業肌肉無法維持力量，而導致活動能力下降。\n\n\t現階段健康食品的抗疲勞功能，乃針對經過運動測試後，延緩運動期間疲勞的發生或促進運動後疲勞消除之評估；亦即對受測對象給予運動測試，觀察運動期間或運動後的休息期間一些疲勞相關數值變化的情形。",
                                                       "RegulateBloodLipidsSegue":"\t根據許多研究資料顯示動脈粥狀硬化 (Atherosclerosis)是導致這些血管疾病的最主要原因。\n\n\t在動物實驗，常以直接解剖或間接測定的方式來探討 動脈粥狀硬化的構致導因或危險因子程度;但在人體 試驗，通常只能採間接的方式，主要常包括測定血清 或血漿之各種脂質或 脂蛋白(Lipoproteins)的含量，以 及其低密度脂蛋白(LDL)氧化程度或對氧化之敏感 度，來評估其可能罹患動脈粥狀硬化的危險機率。",
                                                       "ImmunomodulatorySegue":"\t健康食品的免疫調節功能評估，是針對包括非特異性 及特異性免疫功能之評估。\n\n\t所謂非特異性免疫力主要 包括如中性白血球 (neutrophils)及單核球(monocytes) 的吞噬能力或是自然殺手細胞的活性(natural killer activity)。\n 而特異性免疫力主要是針對一些特定的抗原作進一步 的評估，在老鼠身上可以利用外加注射一些特定的抗 原，再進行抗原特異性免疫反應的評估，其中可以包 括如特異性抗體的測定或是抗原特異性的 T 細胞增殖 反應和細胞激素的研究。",
                                                       "RegulateBloodSugarSegue":"\t血液中主要醣類為葡萄糖，由實驗動物模式或人體試食實驗的研究，經由觀察空腹糖值、葡萄糖耐量、飲食耐量、糖化色素或其他一般生化分析等項目，可了解受試物是否具有調節血糖作用。",
                                                       "AdjustBloodPressureSegue":"\t高血壓為國人近十年來十大死亡原因之一，是心臟冠狀動脈疾病與腦血管病變最重要的危險因素。因此血壓的控制對於中老年人之健康是一重要的預防工作。\n\n\t高血壓是常見的心臟血管系統疾病，在病程晚期才有症狀出現。當長期處於高血壓狀態下，容易造成臟器損傷之併發症，包括：心臟肥厚、心臟衰竭、冠狀動脈硬化、腦中風、主動脈瘤、腎血管疾病、視網膜異常及失明等。\n\n\t以受試物給予原發性高血壓動物(如SHR等)，觀察受試物對高血壓動物模型的收縮壓與舒張壓指標的影響，評價受事務的調節血壓作用。廠商除提供與其產品相關之資料與文獻，以佐證該產品或其部分原料可能具有調節血壓作用的功能及相當之安全性外，必須針對擬以「健康食品」上市之產品，進行下列所規定之「人體試食試驗」。若所提供產品的相關科學研究證據不甚明確時，宜同時進行「動物實驗」和「人體試食試驗」以加強證據之可信度。",
                                                       "PromoteIronAbsorptionSegue":"\t缺鐵為一漸進而連續的變化過程，初期為體內儲存之鐵耗盡，進而使血液中運送之鐵短缺，逐漸不敷造血組織之需要，最後導致血紅素之合成不足，而造成貧血症狀。\n\n\t因此，缺鐵可分為「無貧血性缺鐵」與「缺鐵性貧血」兩大類。由於飲食鐵質之吸收並不完全，故以鐵可用率代表食物或飲食中可被人體正常消化、吸收並供生理利用的鐵，這是綜合數個生理過程的結果，這些過程大致上可分為三個步驟：\n(1)消化，\n(2)小腸細胞攝入鐵與血液運輸，\n(3)形成功能性蛋白質以執行生理功能。\n\t因此，測量上述過程可以反映鐵可用率。經由動物試驗可證明受試物是否具有促進鐵吸收的功效。",
                                                       "DentalCareSegue":"\t齲齒是屬於多因子所造成的疾病，其發生應考慮牙齒組成元素、型態、位置、涎液組成成份、酸鹼值、分泌量、黏度、抗菌因子、飲食中的碳水化合物含量、氟化物、維生素以及其物理性質。\n\n\t齲齒盛行率方面之評佔，在傳統上多以流行病學上之觀察為主，但是牙齒保健功能食品之評估，如從流行病學上齲齒盛行率方面加以評估，必然會耗費過多的人力、時間及金錢，而且在精確度方面，亦會受到質疑，因此，本評估方法採用動物抗齲齒實驗及人體牙菌斑實驗兩項。",
                                                       "AdjustAllergiesSegue":"\t健康食品的「輔助調整過敏體質」功能評估，是減少過敏免疫反應之功能評估。所謂降低過敏免疫反應，針對不同過敏形式有各種過敏反應的指標，例如：降低血清過敏抗體含量、降低發炎反應、減少過品反映相關細胞激素或介質的分泌、調節T細胞分泌細胞激素、降低呼吸阻力等。但必須在不影響正常免疫反應的情況下，對過敏指標有減輕作用，對健康才有助益。若以動物實驗可以過敏原致敏動物，再進行抗原特異性免疫反應的評估。至於人體的改善過敏的評估，可由正常人與過敏侵傾向的人分別進行。",
                                                       "AntiAgingSegue":"\t老化是許多分子、細胞及系統方面的一種ㄧ效應改變。\n\n\t老化細分為功能上、行為上及外表上的變化。老化現象是一種普遍性、進行性、累積性及傷害性之內外因素所引發之生理衰退。\n\n\t動物實驗利用生存實驗(利用生物的整個生存過程來觀察受試物對壽命的影響)、測氧化指標和生化指標。\n\n\t一種健康食品必須以科學方法證明可延緩人體內至少一個以上器官功能衰老的速率或延長服用者之壽命，才能充分取信大眾此食品確有抗老防衰之效能。由於不同器官衰老的速度與原因未必相同，即使證明某食品可延緩甲器官老化，也不可以據以推論此食品也延緩乙器官老化，必須針對不同器官逐一求證才符合科學之精神，但研究者可同時觀測多個器官功能隨老化所發生之變化。",
                                                       "NotEasyToLetBodyFatSegue":"\t保健食品可作為不易形成體脂肪所應用之原理如下：\n\n\t一、調節體內脂質分解作用-活化激素敏感性脂解酶：不易形成體脂肪之過程就是體內脂肪動員作用之過程。許多不易形成體脂肪食品乃是利用其中可以促進脂肪組織分解之物質，減少體脂肪，以達到體重降低之目的。而身體中存在於脂肪組織之激素敏感性脂解酶，可以促進脂肪組織中三酸甘油脂之分解，乃是脂肪分解作用之關鍵酵素。\n\n\t二、調節消化道消化及吸收之功能：不易形成體脂肪食品中亦有許多可以影響消化道消化及吸收之物質，藉此作用減少營養素之吸收，例如：抑制胰脂解酶之分解作用，減少腸道中脂質之分解；或抑制胰澱粉酶和雙糖梅之活性，減少澱粉和雙糖類之消化分解；或促進消化道蠕動，使食物快速通過，減少營養素之消化與吸收等。\n\n\t由於續發性肥胖多因內分泌失調或代謝異常所致，影響因素甚多。因此本功能評估方法以單純性肥胖症為對象，評估保健食品之不易形成體脂肪功能。",
                                                       "InvalidCertificatSeguee":"\t已失效、併証及註銷之憑證"]
}

