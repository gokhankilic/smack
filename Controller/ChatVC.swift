//
//  ChatVC.swift
//  Smack
//
//  Created by Gökhan Kılıç on 12.02.2019.
//  Copyright © 2019 Gökhan Kılıç. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var sideMenu: UIView!
    private var isSideMenuOpened = false
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpMenuButton()
        
    }
    

    @objc func openMenuBtnTapped(_ sender: Any) {
        
        if isSideMenuOpened {
            openSideMenu(open: false)
        }else {
            openSideMenu(open: true)
        }
        
      
        
    }
    
    
    func setUpMenuButton(){
        
        //To add menu bar button item
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 10, height: 5) // we init its frame attributes such as x,y coordinate and width size
        menuBtn.setImage(UIImage(named:"ic_menu_button.png"), for: .normal) // we set image
        menuBtn.addTarget(self, action: #selector(ChatVC.openMenuBtnTapped(_:)), for: .touchUpInside) // we handle tap event for this button
        let menuBarItem = UIBarButtonItem(customView: menuBtn)  // we crate bar button from UIButton
        self.navigationItem.leftBarButtonItem = menuBarItem // we add button to the navigation bar
        
        
        //Selector uses like below , we crate swipe gesture recognize for swiping right,left and we hangle this swiping
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        //Selector uses like below
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        // we handle the swiping actions like below we take the paramater and cast into the UISwipeGestureRecognizer and according to direction we used switch case structure
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                openSideMenu(open: true)
            case UISwipeGestureRecognizer.Direction.left:
                openSideMenu(open: false)

            default:
                break
            }
        }else if gesture is UITapGestureRecognizer {
            openSideMenu(open: false)
        }
    }
    
    
    func openSideMenu(open:Bool) {
        var xCoord:CGFloat
        let width = sideMenu.frame.width
        let height = sideMenu.frame.height
        
        if open{
            xCoord = 0
            
        }else {
            xCoord = -250
        }
        
        
        UIView.animate(withDuration: 0.75) {
            self.sideMenu.frame = CGRect(x: xCoord, y: 0, width: width, height: height)
            self.sideMenu.layoutIfNeeded()
            
        }
        
        isSideMenuOpened = !isSideMenuOpened
    }

}


