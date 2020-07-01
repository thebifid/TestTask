//
//  DetailImageController.swift
//  TestTask
//
//  Created by Vasiliy Matveev on 30.06.2020.
//  Copyright © 2020 Vasiliy Matveev. All rights reserved.
//

import UIKit
import SafariServices

class DetailImageController: UIViewController {
    
    let images: [Image]
    var currentNumber: Int
    
    fileprivate let rightButton = UIButton(title: "Next>>")
    fileprivate let leftButton = UIButton(title: "<<Prev")
    fileprivate let openButton = UIButton(title: "Open")
    
    fileprivate let imageView = UIImageView()
    
    init(images: [Image], currentNumber: Int) {
        self.images = images
        self.currentNumber = currentNumber
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
    
    @objc func handleRightClick() {
        guard currentNumber < images.count - 1 else { return }
        currentNumber += 1
        imageView.sd_setImage(with: URL(string: images[currentNumber].original ?? ""))
    }
    
    @objc func handleLeftClick() {
        guard currentNumber > 1 else { return }
        currentNumber -= 1
        imageView.sd_setImage(with: URL(string: images[currentNumber].original ?? ""))
    }
    
    @objc func handleOpenClick(_ which: Int) {
        if let url = URL(string: images[currentNumber].original ?? "") {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        imageView.sd_setImage(with: URL(string: images[currentNumber].original ?? ""))
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.fillSuperview(padding: .init(top: 0, left: 0, bottom: 120, right: 0))
        
        view.addSubview(closeButton)
        closeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 16), size: .init(width: 44, height: 44))
        
        [rightButton, leftButton, openButton].forEach({
            $0.backgroundColor = .blue
            $0.layer.cornerRadius = 16
            $0.titleLabel?.font = .boldSystemFont(ofSize: 20)
            $0.titleLabel?.textAlignment = .center
            $0.setTitleColor(.white, for: .normal)
        })
        
        let stackView = UIStackView(arrangedSubviews: [
            leftButton,
            openButton,
            rightButton,
        ])
        
        view.addSubview(stackView)
        stackView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 60, right: 10))
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        
        rightButton.addTarget(self, action: #selector(handleRightClick), for: .touchUpInside)
        leftButton.addTarget(self, action: #selector(handleLeftClick), for: .touchUpInside)
        openButton.addTarget(self, action: #selector(handleOpenClick), for: .touchUpInside)
    }
    
}
