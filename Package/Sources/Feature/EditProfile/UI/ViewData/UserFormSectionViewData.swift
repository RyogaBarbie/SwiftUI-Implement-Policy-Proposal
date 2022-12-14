import Foundation
import Model

struct UserFormSectionViewData: Sendable, Equatable {
    var id: String
    var name: String
    var introduction: String
    
    var validatedIdErrorMessage: String? = nil
    var validatedNameErrorMessage: String? = nil
}
