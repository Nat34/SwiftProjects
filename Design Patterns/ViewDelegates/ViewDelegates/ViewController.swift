//
//  ViewController.swift
//  ViewDelegates
//
//  Created by Nathan Thomas on 6/2/22.
//

import UIKit

class ViewController: UIViewController, NotificationSettingViewDelegate {
    
    private let notificationsView = NotificationSettingView()

    override func viewDidLoad() {
        super.viewDidLoad()
        notificationsView.delegate = self
        view.addSubview(notificationsView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        notificationsView.frame = CGRect(x: 10,
                                         y: view.safeAreaInsets.top,
                                         width: view.frame.size.width-20,
                                         height: view.frame.size.height-view.safeAreaInsets.bottom-view.safeAreaInsets.bottom)
    }
    
    func didTapEnableButton() {
        let alert = UIAlertController(title: "title", message: "title", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }


}

protocol NotificationSettingViewDelegate: AnyObject {
    func didTapEnableButton()
}

class NotificationSettingView: UIView {
    
    weak var delegate: NotificationSettingViewDelegate?
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bell")
        imageView.tintColor = .systemBlue
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "To Stay up-to-date enable Push Notifications"
        label.textAlignment = .center
        return label
    }()
    
    private let button: UIButton = {
       let button = UIButton()
        button.setTitle("Something", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(label)
        addSubview(button)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func didTapButton() {
        // Notify controller of tap
        delegate?.didTapEnableButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize = bounds.size.width / 2
        imageView.frame = CGRect(x: (bounds.size.width - imageSize)/2, y: 30, width: imageSize, height: imageSize)
        
        label.frame = CGRect(x: 10, y: 30+imageSize+20, width: frame.size.width-20, height: 100)
        button.frame = CGRect(x: 40, y: 160+imageSize, width: frame.size.width-80, height: 50)

        
    }
    
    

}

