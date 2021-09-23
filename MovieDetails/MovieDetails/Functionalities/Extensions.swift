import Foundation
import UIKit

extension UILabel {
    
    func textWithSF(text: String, symbol: String) {
        let fullText = NSMutableAttributedString()
        let SFsymbol = NSTextAttachment.init(image: UIImage(systemName: symbol)!)
        let SFsymbolString = NSAttributedString(attachment: SFsymbol)
        fullText.append(SFsymbolString)
        fullText.append(NSAttributedString(string: " \(text)"))
        self.attributedText = fullText
    }
}

extension UIButton {
    
    func setButtonSF(symbol: String) {
        let SFsymbol = UIImage(systemName: symbol)?.withTintColor(.label, renderingMode: .alwaysOriginal)
        self.setImage(SFsymbol, for: .normal)
        self.setTitle("", for: .normal)
    }
}
