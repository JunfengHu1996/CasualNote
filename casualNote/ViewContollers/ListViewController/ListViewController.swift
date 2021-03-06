//
//  ListViewController.swift
//  casualNote
//
//  Created by 胡俊峰 on 2/8/20.
//  Copyright © 2020 CasualNotes. All rights reserved.
//

import UIKit

class ListViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    var notes:[Note]?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view?.backgroundColor = .white
        setTitleLabelWithTitle(title: "随记")
        view.addSubview(tableView!)
        view.bringSubviewToFront(addButton)
        notes = getNotes()
        
//        tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadNotes), name:NSNotification.Name.init("success"), object: nil)
        
       
    }
    
//    MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notes!.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = notes![indexPath.row]
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.setLabelViewContentWithNote(note: note)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let row: Int = indexPath.row
        if editingStyle == .delete {
            tableView.beginUpdates()
//            删除数据，刷新notes数组
            deleteNoteWithIndex(index: row)
            
            loadNotes()
//            删除对应行
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    

    @IBAction func popEditView(_ sender: Any) {
        let editVC = EditViewController()
        navigationController?.pushViewController(editVC, animated: false)
    }
    
    @objc func loadNotes() -> Void {
        notes = getNotes()
        tableView.reloadData()
    }
    
}

