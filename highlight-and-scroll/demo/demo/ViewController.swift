//
//  ViewController.swift
//  demo
//
//  Created by Yan Cheng Cheok on 01/03/2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var textView: UITextView!
    
    private func initTextView() {
        textView.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda. Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt      Can you highlight and scroll?      commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTextView()
    }

    @IBAction func click(_ sender: Any) {

        
        let searchedString = "Can you highlight and scroll?"
        
        do {
            let regex = try NSRegularExpression(
                pattern: NSRegularExpression.escapedPattern(for: searchedString),
                options: .caseInsensitive
            )
            
            let targetedString = textView.text!
            
            let range = NSRange(location: 0, length: targetedString.count)
            
            for match in regex.matches(in: targetedString, options: .withTransparentBounds, range: range) {
                print(">>>> found the 1st match")
                highlightAndScroll(match.range)

                break
            }
        } catch {
            print("\(error)")
        }
    }
    
    private func highlightAndScroll(_ range: NSRange) {
        let attributedText = textView.attributedText!
        
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(attributedString: attributedText)
        
        attributedString.removeAttribute(NSAttributedString.Key.backgroundColor, range: range)
        
        attributedString.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.yellow, range: range)
        
        textView.attributedText = attributedString
        
        // https://stackoverflow.com/questions/14376341/finding-x-y-coordinate-of-specified-word-in-uitextview
        let beginning: UITextPosition? = textView.beginningOfDocument
        let start: UITextPosition? = textView.position(from: beginning!, offset: range.location)
        let end: UITextPosition? = textView.position(from: start!, offset: range.length)
        let textRange: UITextRange? = textView.textRange(from: start!, to: end!)
        let textRect: CGRect = textView.firstRect(for: textRange!)
        
        var scrollViewBounds = scrollView.bounds
        // Use *2, so that the highlighted text will not too close to screen edge.
        let scrollToRect = CGRect(
            x: scrollViewBounds.minX,
            y: textRect.minY + textView.frame.minY,
            width: scrollViewBounds.width,
            height: textRect.height * 2
        )
        
        print(">>>> scrollToRect \(scrollToRect)")
        
        scrollView.scrollRectToVisible(scrollToRect, animated: true)
    }
}

