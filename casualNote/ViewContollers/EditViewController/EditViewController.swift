//
//  EditViewController.swift
//  casualNote
//
//  Created by 胡俊峰 on 2/8/20.
//  Copyright © 2020 CasualNotes. All rights reserved.
//

import UIKit

class EditViewController: BaseViewController {
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.font = .systemFont(ofSize: 25)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: .done, target: self, action: #selector(saveNote))
        
//        navigationItem.leftBarButtonItem?.title = "返回"， 这样修改没用
        let backButton = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(popView))
        navigationItem.leftBarButtonItem = backButton
        
//        解决TextView文字不在最开始的地方
        self.automaticallyAdjustsScrollViewInsets = false
        
        
//        待会根据是编辑状态还是新建状态
        setTitleLabelWithTitle(title: "写笔记")
        textView.becomeFirstResponder()
    }

// MARK: Actions
    @objc func saveNote() {
        saveNotesWithSingleNote(note: Note(content: textView.text, timestamp: getTimestamp()))
        
        NotificationCenter.default.post(name:NSNotification.Name.init("success"), object:nil)

        navigationController?.popViewController(animated: true )
    }
    
    @objc func popView() {
        navigationController?.popViewController(animated: true)
    }

}
