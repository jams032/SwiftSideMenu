//
//  ViewController.swift
//  SwiftSideMenu
//
//  Created by  on 10/2/19.
//  Copyright © 2019 Jamshed Alam. All rights reserved.
//

import UIKit
import WebKit
import QuartzCore

@available(iOS 11.0, *)
class WebViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , UIGestureRecognizerDelegate { //MenuListViewModelDelegate

    @IBOutlet var leftTableView: UITableView!
    @IBOutlet var rightTableView: UITableView!
    
    var leftMenus = [MenuModel]()
    var rightMenus = [MenuModel]()
    
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var screenTitle: UILabel!
    @IBOutlet var dotImageView: UIImageView!

    
    @IBOutlet weak var leftMenuView: UIView!
    @IBOutlet weak var rightMenuView: UIView!
    
    @IBOutlet weak var versionView: UIView!
    @IBOutlet weak var versionLevel: UILabel!
    
    @IBOutlet var leftMenuLeadingConstant: NSLayoutConstraint!
    @IBOutlet var rightMenuTrailingConstant: NSLayoutConstraint!
    @IBOutlet var leftmMenuWidthConstant: NSLayoutConstraint!

    @IBOutlet weak var leftMenuButton: UIButton!
    @IBOutlet weak var rightMenuButton: UIButton!
    
    @IBOutlet weak var linearProgressBarHolder: UIView!
    @IBOutlet weak var fakeViewForTouchDetect: UIView!

    var maxWidth : CGFloat = -5.0
    var isViewLoad = false
    
   // let viewModel = MenuListViewModel() // if you want to call menu api in MVVM
   // var allMenusData = MenuListModel()
    
    // MARK: - Override methood
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.screenTitle.text = DEFAULT_TITLE

        // UI set UP
        self.resetUI()
        self.addNavBarBottomLayer()
        self.setTapGestureToFakeView()

        isViewLoad = false
        self.callTableViewFakeLoader()
        
        
        //Menu Data
        //viewModel.delegate = self
       // allMenusData = PSUserDefaults.getMenuData()
        
        // Set test left menu data
        let leftMenuModel = MenuModel.init(Label: "Test1", Url: "", Rank: 1, Children: [MenuModel()], isSubMenu: 0)
        let leftMenuModel2 = MenuModel.init(Label: "Test1", Url: "", Rank: 1, Children: [MenuModel()], isSubMenu: 0)
        let leftMenuModel3 = MenuModel.init(Label: "Test1", Url: "", Rank: 1, Children: [MenuModel()], isSubMenu: 0)
        leftMenus.append(leftMenuModel)
        leftMenus.append(leftMenuModel2)
        leftMenus.append(leftMenuModel3)
        
        
        // Set test Right menu data
        let RightMenuModel = MenuModel.init(Label: "Test1", Url: "", Rank: 1, Children: [MenuModel()], isSubMenu: 0)
        let RightMenuModel2 = MenuModel.init(Label: "Test1", Url: "", Rank: 1, Children: [MenuModel()], isSubMenu: 0)
        let RightMenuModel3 = MenuModel.init(Label: "Test1", Url: "", Rank: 1, Children: [MenuModel()], isSubMenu: 0)
        rightMenus.append(RightMenuModel)
        rightMenus.append(RightMenuModel2)
        rightMenus.append(RightMenuModel3)
        

    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        self.adJustLeftmenuSize()
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }
    
    override func viewDidDisappear(_ animated: Bool) {
    }
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
    
    override func viewDidLayoutSubviews() {
        
        if navBarView != nil {
            navBarView.layoutIfNeeded()
            navBarView.setNeedsLayout()
        }

    }
    
    
    // MARK: - UITableView (Menus) delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tableView == self.leftTableView {
            return leftMenus.count
        }
        return rightMenus.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return CGFloat(0.0)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        if tableView == self.leftTableView {
            if isViewLoad {
                if indexPath.row > 0 { // Submenu must be from index > 0
                    
                    let cells = self.leftTableView.visibleCells
                    var cell = DrawerTableViewCell()
                    if cells.count > 0 {
                        cell = cells[0] as! DrawerTableViewCell
                    }
                    
                    let font = UIFont(name: Page_Title_Font_SEMI_BOLD, size: Menu_SIZE)!
                    let menuText = "\(self.leftMenus[indexPath.row].Label ?? "")"
                    let sizeOfText : CGSize = menuText.textWidth(text: menuText , font: font)
                    if self.leftMenus[indexPath.row].isSubMenu.intValue == 0 {
                        if cell.frame.size.width - 35 < sizeOfText.width  {
                            let hgt =  menuText.textHeight(withConstrainedWidth: cell.menuLabel.frame.size.width, font: font)
                            return MenuRowHeight*(hgt/MenuRowHeight)
                        }
                        else { return MenuRowHeight }
                    }
                    else  {
                        if cell.frame.size.width < sizeOfText.width + 45 {
                            let hgt =  menuText.textHeight(withConstrainedWidth: cell.SubMenuLabel.frame.size.width, font: font)
                            return MenuRowHeight*(hgt/MenuRowHeight)
                        }
                        else { return MenuRowHeight }
                    }
                }
                else { return MenuRowHeight }
            }
            return MenuRowHeight
        }
        else {
            return MenuRowHeight
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{

        if tableView == self.leftTableView {
            
            var cell : DrawerTableViewCell!
            if let cellD = tableView.dequeueReusableCell(withIdentifier: "DrawerTableViewCell") {
                cell = cellD as? DrawerTableViewCell
            }
            else{
                let nibs =  Bundle.main.loadNibNamed("DrawerTableViewCell", owner: self, options: nil)
                cell = nibs?.first as? DrawerTableViewCell
            }

            if self.leftMenus[indexPath.row].isSubMenu.intValue == 0 {
                cell.menuLabel.text = "\(self.leftMenus[indexPath.row].Label ?? "")"
                cell.SubMenuLabel.text = ""
            } else {
                cell.menuLabel.text =  ""
                cell.SubMenuLabel.text = "\(self.leftMenus[indexPath.row].Label ?? "")"
            }
            cell.menuLabel.textAlignment = .left
            cell.SubMenuLabel.textAlignment = .left

            cell.menuLabel.numberOfLines = 0
            cell.SubMenuLabel.numberOfLines = 0

            cell.menuLabel.font = UIFont(name: Page_Title_Font_SEMI_BOLD, size: Menu_SIZE)!
            cell.SubMenuLabel.font = UIFont(name: Page_Title_Font_SEMI_BOLD, size: Menu_SIZE)!
            cell.menuLabel.textColor = Utility.hexStringToUIColor(hex: MENU_TEXT_COLOR, alpha: 1)
            cell.SubMenuLabel.textColor = Utility.hexStringToUIColor(hex: MENU_TEXT_COLOR, alpha: 1)

            cell.menuLabel.backgroundColor = UIColor.clear //clear
            cell.SubMenuLabel.backgroundColor = UIColor.clear //clear

            cell.backgroundColor  = UIColor.clear
            cell.contentView.backgroundColor  = UIColor.clear
            cell.contentView.backgroundColor  = Utility.hexStringToUIColor(hex: Menu_BG_COLOR, alpha: 1)
            cell.selectionStyle = .none
            
            if isViewLoad {
                let sizeOfText : CGSize = cell.SubMenuLabel.text!.textWidth(text: cell.SubMenuLabel.text! , font: cell.SubMenuLabel.font)
                if sizeOfText.width  > cell.SubMenuLabel.frame.size.width {
                    let tempWidth = sizeOfText.width  - cell.SubMenuLabel.frame.size.width
                    if maxWidth < tempWidth {
                        print("Frame width updated \(indexPath.row) : \(tempWidth) : \(cell.SubMenuLabel.frame.size.width)")
                        maxWidth = tempWidth
                    }
                }
            }
            return cell
            
        } else {
            
            var cell : DrawerTableViewRightCell!
            if let cellD = tableView.dequeueReusableCell(withIdentifier: "DrawerTableViewRightCell") {
                cell = cellD as? DrawerTableViewRightCell
            }
            else{
                let nibs =  Bundle.main.loadNibNamed("DrawerTableViewRightCell", owner: self, options: nil)
                cell = nibs?.first as? DrawerTableViewRightCell
            }
            
            if self.rightMenus[indexPath.row].isSubMenu.intValue == 0 {
                cell.menuLabel.text = self.rightMenus[indexPath.row].Label ?? ""
            } else {
                cell.menuLabel.text = "    \(self.rightMenus[indexPath.row].Label ?? "")"
            }
            cell.menuLabel.textAlignment = .right
            
            cell.menuLabel.numberOfLines = 0
            cell.menuLabel.font = UIFont(name: Page_Title_Font_SEMI_BOLD, size: Menu_SIZE)!
            cell.menuLabel.textColor = Utility.hexStringToUIColor(hex: MENU_TEXT_COLOR, alpha: 1)
            cell.menuLabel.backgroundColor = UIColor.clear
            cell.backgroundColor  = UIColor.clear
            cell.contentView.backgroundColor  = UIColor.clear
            cell.contentView.backgroundColor  = Utility.hexStringToUIColor(hex: Menu_BG_COLOR, alpha: 1)
            cell.selectionStyle = .none
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
       
        if tableView == self.leftTableView {
            
            let cell:DrawerTableViewCell = tableView.cellForRow(at: indexPath) as! DrawerTableViewCell
            cell.contentView.backgroundColor = Utility.hexStringToUIColor(hex: APP_BAR_BG_COLOR, alpha: 1)
            cell.menuLabel.textColor = UIColor.white
            
        } else {
            
            let cell:DrawerTableViewRightCell = tableView.cellForRow(at: indexPath) as! DrawerTableViewRightCell
            cell.contentView.backgroundColor = Utility.hexStringToUIColor(hex: APP_BAR_BG_COLOR, alpha: 1)
            cell.menuLabel.textColor = UIColor.white
        }
        
        
    }
    
    func reloadCellData (indexPath : IndexPath , isLeft : Bool) {
        
        
    }
    


    
    
   
    
    // This method is written for controlling width and height of left menu text; Menu size is minimum 75% of the screen. But when the text is more width , menu width should be increased and it could be extented up to 100%. Even then, text area is not covered with full screen menu, rows height should be increased. Warpping menus text width height is native in android , but we were ask to do so in iOS at any cost. We have done a fake reload of left uitable and calculate the text width and adjust the leading position with adJustLeftmenuSize() method.
    func callTableViewFakeLoader () {
      _ = Timer.scheduledTimer(timeInterval: 0.20, target: self, selector: (#selector(self.loadLeftTableFirstTime)), userInfo: nil, repeats: false)
    }
    
    @objc func loadLeftTableFirstTime() {
        self.isViewLoad = true
        self.leftTableView.reloadData()
        _ = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: (#selector(self.adJustLeftmenuSize)), userInfo: nil, repeats: false)
    }
    

   
    
  
    // MARK: - UI & User Interaction related method
    @objc func adJustLeftmenuSize () {

        if isViewLoad  && maxWidth > 0.0    {
            print("haha:TRICK work")
            LEFT_DRAWER_SIZE_RATIO = LEFT_DRAWER_SIZE_RATIO + maxWidth //+ 10
            if LEFT_DRAWER_SIZE_RATIO > DEVICE_SIZE.width {
                LEFT_DRAWER_SIZE_RATIO = DEVICE_SIZE.width
                print(LEFT_DRAWER_SIZE_RATIO)
            }
        }
        
        self.leftMenuLeadingConstant.constant = -(LEFT_DRAWER_SIZE_RATIO)
        self.leftmMenuWidthConstant.constant = (LEFT_DRAWER_SIZE_RATIO)
        
        self.leftMenuView.frame = CGRect(x: self.leftMenuLeadingConstant.constant, y: self.leftMenuView.frame.origin.y , width: self.leftmMenuWidthConstant.constant, height: self.leftMenuView.frame.size.height)
        self.leftTableView.frame = CGRect(x: self.leftTableView.frame.origin.x, y: self.leftTableView.frame.origin.y  , width: self.leftmMenuWidthConstant.constant, height: self.leftTableView.frame.size.height)
        self.rightMenuTrailingConstant.constant =  CGFloat(DEVICE_WIDTH)
        
    }



    func addNavBarBottomLayer () {
        
        navBarView.layer.masksToBounds = false
        navBarView.layer.shadowOpacity = 1
        navBarView.layer.shadowRadius = NavBarBottomShadowSize
        navBarView.layer.shadowColor = UIColor.lightGray.cgColor
        navBarView.layer.shadowOffset = CGSize(width: 0 , height:2)
        self.view.bringSubviewToFront(self.navBarView)
    }
    
    func resetUI() {
        
        // UI title and Menu
        self.screenTitle.font = UIFont(name: Page_Title_Font_SEMI_BOLD, size: Page_Title_Font_SIZE)!
        self.screenTitle.textColor = Utility.hexStringToUIColor(hex: APP_BAR_BG_COLOR, alpha: 1)
        self.leftTableView.backgroundColor =  Utility.hexStringToUIColor(hex: Menu_BG_COLOR, alpha: 1)
        self.rightTableView.backgroundColor = Utility.hexStringToUIColor(hex: Menu_BG_COLOR, alpha: 1)
        self.navBarView.backgroundColor = UIColor.white
        self.leftMenuView.backgroundColor = Utility.hexStringToUIColor(hex: Menu_BG_COLOR, alpha: 1)
        self.rightMenuView.backgroundColor = Utility.hexStringToUIColor(hex: Menu_BG_COLOR, alpha: 1)
        
        
        // UI Version Number
        self.versionView.backgroundColor = Utility.hexStringToUIColor(hex: MENU_TEXT_COLOR, alpha: 1)
        self.versionLevel.font = UIFont(name: Page_Title_Font_BOOK, size: Menu_SIZE )
        self.versionLevel.text =  Utility.getVersionNumber()
        self.versionLevel.textColor = UIColor.white

        // Menu Button color
        self.leftMenuButton.tintAdjustmentMode = .normal
        self.leftMenuButton.layer.masksToBounds = true
        self.leftMenuButton.layer.cornerRadius = buttonCornerRatio
        self.leftMenuButton.layer.borderWidth = 2
        self.leftMenuButton.layer.borderColor = UIColor.gray.cgColor
        
        // fake view hide
        self.fakeViewForTouchDetect.isHidden = true
    }
    
    
    @IBAction func leftMenuAction(_ sender: UIButton) {
        
        if self.leftMenus.count == 0 {
            return
        }

        self.leftTableView.reloadData()
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
            if self.leftMenuLeadingConstant.constant == 0.0 {
                self.leftMenuLeadingConstant.constant = -LEFT_DRAWER_SIZE_RATIO
                self.fakeViewForTouchDetect.isHidden = true
                self.leftMenuView.frame = CGRect(x: -LEFT_DRAWER_SIZE_RATIO, y:self.rightMenuView.frame.origin.y, width: self.leftMenuView.frame.size.width, height: self.leftMenuView.frame.size.height)
                
            } else {
                self.leftMenuLeadingConstant.constant = 0
                self.fakeViewForTouchDetect.isHidden = false

                self.leftMenuView.frame = CGRect(x: 0, y: self.rightMenuView.frame.origin.y, width: self.leftMenuView.frame.size.width, height: self.leftMenuView.frame.size.height)
            }
            //self.leftTableView.frame.origin.y
            self.rightMenuTrailingConstant.constant = DEVICE_SIZE.width
            self.rightMenuView.frame = CGRect(x: DEVICE_SIZE.width, y: self.rightMenuView.frame.origin.y, width: self.rightMenuView.frame.size.width, height: self.rightMenuView.frame.size.height)
            
        }, completion: { (finished: Bool) in
            
            self.leftMenuView.layoutIfNeeded()
            self.leftMenuView.setNeedsLayout()
            
            self.rightMenuView.layoutIfNeeded()
            self.rightMenuView.setNeedsLayout()
            
        })
        
    }
    
    @IBAction func rightMenuAction(_ sender: UIButton) {
        
        
        self.rightTableView.reloadData()
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
            if self.rightMenuTrailingConstant.constant == DEVICE_SIZE.width {
                self.rightMenuTrailingConstant.constant =   (DEVICE_SIZE.width - RIGHT_DRAWER_SIZE_RATIO)
                self.fakeViewForTouchDetect.isHidden = false

                self.rightMenuView.frame = CGRect(x: (DEVICE_SIZE.width - RIGHT_DRAWER_SIZE_RATIO) , y: self.rightMenuView.frame.origin.y, width: self.rightMenuView.frame.size.width, height: self.rightMenuView.frame.size.height)
                
            } else {
                self.rightMenuTrailingConstant.constant = DEVICE_SIZE.width
                self.fakeViewForTouchDetect.isHidden = true
                self.rightMenuView.frame = CGRect(x: DEVICE_SIZE.width, y: self.rightMenuView.frame.origin.y, width: self.rightMenuView.frame.size.width, height: self.rightMenuView.frame.size.height)
            }
            
            self.leftMenuLeadingConstant.constant = -LEFT_DRAWER_SIZE_RATIO
            self.leftMenuView.frame = CGRect(x: -LEFT_DRAWER_SIZE_RATIO, y: self.rightMenuView.frame.origin.y, width: self.leftMenuView.frame.size.width, height: self.leftMenuView.frame.size.height)
            
        }, completion: { (finished: Bool) in
            
            self.rightMenuView.layoutIfNeeded()
            self.rightMenuView.setNeedsLayout()
            
            self.leftMenuView.layoutIfNeeded()
            self.leftMenuView.setNeedsLayout()
        })
        
    }
    
    func setTapGestureToFakeView() {
        
        let allViews = [self.navBarView  , self.fakeViewForTouchDetect]
        for item in allViews {
            let TapGestureToFakeView = UITapGestureRecognizer(target: self, action: #selector(showFakeView(tapGestureRecognizer:)))
            item!.isUserInteractionEnabled = true
            item!.addGestureRecognizer(TapGestureToFakeView)
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc func showFakeView(tapGestureRecognizer: UITapGestureRecognizer) {
        
        if self.rightMenuTrailingConstant.constant != DEVICE_SIZE.width {
            self.rightMenuAction(UIButton())
        } else if self.leftMenuLeadingConstant.constant == 0.0 {
            self.leftMenuAction(UIButton())
        }
        
    }
   
   
}



