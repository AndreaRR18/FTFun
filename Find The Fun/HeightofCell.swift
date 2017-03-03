import Foundation
import UIKit

func heightRowInGameDescription(indexPath: Int) -> CGFloat {
    switch indexPath {
    case 0:
        return 100
    case 1:
        return 90
    case 2:
        return 200
    case 3:
        return 60
    case 4:
        return 60
    case 5:
        return 60
    case 6:
        return 60
    case 7:
        return 150
    case 8:
        return 60
    case 9:
        return 160
    default:
        return 0
    }
}


func heightSummary(_ numberOfCharacters: Int) -> CGFloat {
    if numberOfCharacters < 50 {
        return 40
    } else if numberOfCharacters < 100 {
        return 80
    } else if numberOfCharacters < 150 {
        return 120
    } else if numberOfCharacters < 200 {
        return 160
    } else if numberOfCharacters < 250 {
        return 200
    } else if numberOfCharacters < 300 {
        return 240
    } else if numberOfCharacters < 350 {
        return 280
    } else if numberOfCharacters < 400 {
        return 320
    } else if numberOfCharacters < 450 {
        return 360
    } else if numberOfCharacters < 500 {
        return 400
    } else if numberOfCharacters < 550 {
        return 440
    } else if numberOfCharacters < 600 {
        return 480
    } else {
        return 520
    }
}