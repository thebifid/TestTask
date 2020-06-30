//
//  DetailImageController.swift
//  TestTask
//
//  Created by Vasiliy Matveev on 30.06.2020.
//  Copyright © 2020 Vasiliy Matveev. All rights reserved.
//

import UIKit

class DetailImageController: UIViewController {
    
    //fileprivate let urlString: String
    
    
    let urlString : String
    
    let imageView = UIImageView()
    
    init(urlString: String) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        button.tintColor = .darkGray
        return button
    }()
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    let rightButton = UIButton(title: "Next>>")
    let leftButton = UIButton(title: "<<Prev")

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        imageView.sd_setImage(with: URL(string: urlString))
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.fillSuperview(padding: .init(top: 0, left: 0, bottom: 120, right: 0))
        
        view.addSubview(closeButton)
        closeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 16), size: .init(width: 44, height: 44))
        
        [rightButton, leftButton].forEach({
            $0.backgroundColor = .blue
            $0.layer.cornerRadius = 16
            $0.titleLabel?.font = .boldSystemFont(ofSize: 20)
            $0.titleLabel?.textAlignment = .center
            $0.setTitleColor(.white, for: .normal)
            view.addSubview($0)
        })
        
        rightButton.anchor(top: nil, leading: nil, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 40, right: 40), size: .init(width: 140, height: 0))
        
        leftButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 40, bottom: 40, right: 0), size: .init(width: 140, height: 0))
        
    }
    
    
    
    
}
