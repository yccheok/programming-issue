//
//  ViewController.swift
//  demo
//
//  Created by Yan Cheng Cheok on 01/03/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    private func initTextView() {
        textView.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda. Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt      Can you highlight and scroll?      commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTextView()
    }

    @IBAction func click(_ sender: Any) {
        let attributedText = textView.attributedText!
        
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(attributedString: attributedText)
        
        let range = NSRange(location: 0, length: attributedString.length)
        
        attributedString.removeAttribute(NSAttributedString.Key.backgroundColor, range: range)
        
        let searchedString = "Can you highlight and scroll?"
        
        do {
            let regex = try NSRegularExpression(
                pattern: NSRegularExpression.escapedPattern(for: searchedString),
                options: .caseInsensitive
            )
            
            let targetedString = attributedString.string
            
            for match in regex.matches(in: targetedString, options: .withTransparentBounds, range: range) {
                print(">>>> found the 1st match")
                attributedString.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.yellow, range: match.range)
                break
            }
        } catch {
            print("\(error)")
        }
        
        textView.attributedText = attributedString
        
        // TODO: How can we perform scrolling to make the highlight text visible?
    }
    
}

