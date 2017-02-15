//
//  ListViewController2.swift
//  Paper
//
//  Created by cscoi005 on 2017. 2. 14..
//  Copyright © 2017년 PSJ. All rights reserved.
//

import UIKit
import SWXMLHash

class ListViewController3: UITableViewController {
    
    var page = 1
    var totalcount2 = 0
    
    lazy var list : [PaperVO] = {
        var datalist = [PaperVO]()
        return datalist
    }()
    
    override func viewDidLoad() {
        
        self.callPaperAPI()
        
    }
    
    
    func callPaperAPI(){
        let url = "http://www.riss.kr/openApi?key=70aaa00tte60abr00aaa00ro00na481a&version=1.0&type=A&keyword=스마트폰&rsnum=\(self.page)"
        let urlwithPercentEscapes = url.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        let apiURI : URL! = URL(string: urlwithPercentEscapes!)
        
        
        do {
            let apidata = try! Data(contentsOf: apiURI)
            let xml = SWXMLHash.parse(apidata)
            let totalcount = xml["record"]["head"]["totalcount"].element?.text
            totalcount2 = Int(totalcount!)!
            
            
            
            for row in 0...9 {
                
                if row-1 == Int(totalcount!)!-self.page{
                    break
                }
                
                let r = xml["record"]["metadata"][row]
                let pvo = PaperVO()
                pvo.title = r["riss.title"].element?.text
                pvo.author = r["riss.author"].element?.text
                
                self.list.append(pvo)
                
            }
            
        }
        catch{
            NSLog("Parse Error!!")
            
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.list.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = self.list[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! PaperCell
        
        cell.Title?.text = row.title
        cell.Author?.text = row.author
        
        
        
        
        
        // Configure the cell...
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath.row) 번째 행입니다")
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(tableView.contentOffset.y >= (tableView.contentSize.height - tableView.frame.size.height) && totalcount2-self.page>=10) {
            self.page += 10
            self.callPaperAPI()
            self.tableView.reloadData()
            NSLog("\(self.page)")
            
            
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // 실행된 세그웨이의 식별자가 segue_detail"이라면
        if segue.identifier == "segue_detail" {
            // sender 인자를 캐스팅하여 테이블 셀 객체로 변환한다.
            let cell = sender as! PaperCell
            
            // 첫번째 인자값을 이용하여 사용자가 몇번째 행을 선택했는지 확인한다.
            let path = self.tableView.indexPath(for: cell)
            
            // API 영화 데이터 배열 중에서 선택된 행에 대한 데이터를 추출한다.
            let movieinfo = self.list[path!.row]
            print("mi ============ \(movieinfo)")
            // 행 정보를 통해 선택된 영화 데이터를 찾은 다음, 목적지 뷰 컨트롤러의 mvo 변수에 대입한다.
            let detailVC = segue.destination as? DetailViewController
            detailVC?.mvo = movieinfo
        }
    }

    
    
}
