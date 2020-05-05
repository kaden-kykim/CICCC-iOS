//
//  DeadlinePickerViewController.swift
//  SimpleTodoApp
//
//  Created by Kaden Kim on 2020-05-04.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

protocol SetDateDelegate: class {
    func setDate(date: Date)
}

class DeadlinePickerViewController: UIViewController {
    
    let pickerHeight = CGFloat(290)
    var isPresenting = false
    var date: Date!
    
    weak var delegate: SetDateDelegate?
    
    lazy var backdropView: UIView = {
        let bdView = UIView(frame: self.view.bounds)
        return bdView
    }()
    
    let pickerView: UIView = {
        let pView = UIView()
        pView.translatesAutoresizingMaskIntoConstraints = false
        pView.backgroundColor = .systemBackground
        pView.layer.cornerRadius = 25
        pView.clipsToBounds = true
        return pView
    }()
    
    let navigationBar: UINavigationBar = {
        let navBar = UINavigationBar()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        let navCancel = UIBarButtonItem()
        navCancel.title = "Cancel"
        navCancel.action = #selector(DeadlinePickerViewController.dismissViewController)
        let navSet = UIBarButtonItem()
        navSet.title = "Set"
        navSet.action = #selector(DeadlinePickerViewController.pickDate)
        
        let navItem = UINavigationItem()
        navItem.leftBarButtonItem = navCancel
        navItem.rightBarButtonItem = navSet
        
        navBar.pushItem(navItem, animated: true)
        
        return navBar
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.heightAnchor.constraint(equalToConstant: 250).isActive = true
        datePicker.datePickerMode = .dateAndTime
        datePicker.minuteInterval = 5
        return datePicker
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        view.addSubview(backdropView)
        view.addSubview(pickerView)
        
        datePicker.date = date
        
        pickerView.heightAnchor.constraint(equalToConstant: pickerHeight).isActive = true
        pickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        pickerView.addSubview(navigationBar)
        pickerView.addSubview(datePicker)
        
        navigationBar.widthAnchor.constraint(equalTo: pickerView.widthAnchor).isActive = true
        navigationBar.topAnchor.constraint(equalTo: pickerView.topAnchor, constant: 0).isActive = true
        
        datePicker.widthAnchor.constraint(equalTo: pickerView.widthAnchor).isActive = true
        datePicker.topAnchor.constraint(equalTo: navigationBar.bottomAnchor).isActive = true
        
        backdropView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DeadlinePickerViewController.dismissViewController)))
    }
    
    @objc func dismissViewController(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func pickDate() {
        self.delegate?.setDate(date: datePicker.date)
        dismiss(animated: true, completion: nil)
    }
    
}

extension DeadlinePickerViewController : UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toViewcontroller = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        guard let toVC = toViewcontroller else { return }
        isPresenting = !isPresenting
        
        if isPresenting {
            containerView.addSubview(toVC.view)
            pickerView.frame.origin.y += pickerHeight
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
                self.pickerView.frame.origin.y -= self.pickerHeight
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn], animations: {
                self.pickerView.frame.origin.y += self.pickerHeight
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        }
    }
    
    
}
