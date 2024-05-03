//
//  ResultStatus.swift
//  InvadeTask
//
//  Created by Mohamad Basuony on 02/05/2024.
//

import Foundation

public enum ResultStatus<Model> {
    case success(Model)
    case failure(Error?)
}
