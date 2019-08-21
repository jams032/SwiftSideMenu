
import UIKit

public class LinearProgressBar: UIView {
    
    //FOR DATA
    private var screenSize: CGRect = UIScreen.main.bounds
    
    
    private var isAnimationRunning = false
    
    //FOR DESIGN
    private var progressBarIndicator: UIView!
    
    //PUBLIC VARS
    public var backgroundProgressBarColor: UIColor = UIColor(red:255, green:255, blue:255, alpha:1.0)
    public var progressBarColor: UIColor = UIColor(red:0, green:183, blue:233, alpha:1.0)
    public var heightForLinearBar: CGFloat = 2.5
    public var widthForLinearBar: CGFloat = 0
    
    public init () {
        
        super.init(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 0))
        self.progressBarIndicator = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: heightForLinearBar))
    }
    
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.progressBarIndicator = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: heightForLinearBar))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: LIFE OF VIEW
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.screenSize = UIScreen.main.bounds
        
        if widthForLinearBar == 0 || widthForLinearBar == self.screenSize.height {
            widthForLinearBar = self.screenSize.width
        }
        self.frame =  CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width:widthForLinearBar, height: self.frame.height)
    }
    
    //Start the animation
    public func startAnimation(){
        
        
        self.configureColors()
        
        
        if !isAnimationRunning {
            
            self.isAnimationRunning = true
            
            UIView.animate(withDuration: 0.5, delay:0, options: [], animations: {
                
                self.frame = CGRect(x: 0, y: self.frame.origin.y, width: self.heightForLinearBar, height: self.heightForLinearBar)
                
            }, completion: { animationFinished in
                
                self.addSubview(self.progressBarIndicator)
                self.configureAnimation()
            })
        }
        
    }
    
    //Start the animation
    public func stopAnimation() {
        
        self.isAnimationRunning = false
        
        UIView.animate(withDuration: 0.5, animations: {
            self.progressBarIndicator.frame = CGRect(x: 0, y: 0, width: self.widthForLinearBar, height: 0)
            self.frame = CGRect(x: 0, y: self.frame.origin.y, width: self.widthForLinearBar, height: 0)
        })
        
    }
    
    private func configureColors(){
        self.backgroundColor = self.backgroundColor
        self.progressBarIndicator.backgroundColor = self.progressBarColor
    }
    
    private func configureAnimation() {
        
        
        let animDuration = 1.80
        let ProgressbarWidth = 130
        let ProgressbarNumber :Int = Int(self.frame.width) / ProgressbarWidth
        self.progressBarIndicator.frame = CGRect(x: 0, y: 0, width: ProgressbarWidth, height: Int(heightForLinearBar))
       // print(self.frame)
        
        for index in 1...ProgressbarNumber {

            UIView.animate(withDuration: animDuration, delay:0, options: [], animations: {
                
                if index == ProgressbarNumber  {
                    self.progressBarIndicator.frame = CGRect(x: Int(self.frame.width), y: 0, width: ProgressbarNumber + index*80 , height: Int(self.heightForLinearBar))
                } else {
                    self.progressBarIndicator.frame = CGRect(x: ProgressbarWidth*index, y: 0, width: ProgressbarWidth + index * 80 , height: Int(self.heightForLinearBar) )
                }
                //print(self.progressBarIndicator.frame)
                
            }, completion:  { (finished: Bool) in
                
                if index == ProgressbarNumber  {
                    
                    if (self.isAnimationRunning) {
                       // print("Finished")
                        self.configureAnimation()
                    }
                }
            })
        }
        
    }
    
}
