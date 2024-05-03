//
//  ResultError.swift
//  InvadeTask
//
//  Created by Mohamad Basuony on 02/05/2024.
//

import Foundation
import UIKit

// MARK: - Validation Error

struct ValidationError: LocalizedError {
    private var message: String?

    private var data: Data?
    init(_ message: String?) {
        self.message = message
    }

    init(data: Data?) {
        self.data = data
    }

    private func errorValidation(data: Data?) -> ServerErrorModel? {
        let decoder = JSONDecoder()
        guard let _data = data, let model = try? decoder.decode(ServerErrorModel.self, from: _data) else {
            return nil
        }
        return model
    }

    var errorDescription: String? {
        return message ?? errorValidation(data: data)?.message
    }

    private struct ServerErrorModel: Codable {
        var message: String?
    }
}

struct CancelledError: LocalizedError {
    var errorDescription: String? {
        return NSLocalizedString("The operation has been cancelled", comment: "")
    }
}

// MARK: - NOInterntError

struct NoInternetError: LocalizedError {
    var isNoInternet: Bool = false
    var errorDescription: String? {
        return NSLocalizedString("No Internet connection. \n Make sure that Wi-Fi or mobile data is turned on, then try again", comment: "")
    }
}

// MARK: - Bad URL

struct BadURLError: LocalizedError {
    var errorDescription: String? {
        return NSLocalizedString("You cannot access this operation", comment: "")
    }
}

// MARK: - Internal Server Error

struct InternalServerError: LocalizedError {
    var errorDescription: String? {
        return NSLocalizedString("Internal server error, please try again!", comment: "")
    }
}
