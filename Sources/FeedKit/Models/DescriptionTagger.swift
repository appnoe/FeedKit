//
//  DescriptionTagger.swift
//  FeedKit Example iOS
//
//  Created by Klaus Rodewig on 13.05.18.
//

import UIKit

class DescriptionTagger {

    fileprivate let text: String

    init(inText : String){
        self.text = inText;
    }

    public func namesPlacesAndOrganisations () -> NSAttributedString {
        let theTagger = NSLinguisticTagger(tagSchemes: [.nameType, .tokenType], options: 0)
        theTagger.string = self.text

        let theRange = NSRange(location:0, length: self.text.utf16.count)
        let theOptions: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]
        let theTags: [NSLinguisticTag] = [.personalName, .placeName, .organizationName]

        let formattedDesciptionBasedOnTags = NSMutableAttributedString(string: self.text)
        let formattedDesciptionBasedOnTagsFontBold = UIFont(name:"Helvetica-Bold", size:16)!

        theTagger.enumerateTags(in: theRange, unit: .word, scheme: .nameType, options: theOptions) { tag, tokenRange, stop in
            if let tag = tag, theTags.contains(tag) {
                formattedDesciptionBasedOnTags.addAttribute(NSAttributedStringKey.font, value:formattedDesciptionBasedOnTagsFontBold, range:tokenRange)
            }
        }
        return formattedDesciptionBasedOnTags
    }
}
