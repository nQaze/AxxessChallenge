//
//  GCDBlackBox.swift
//  AxxessChallenge
//
//  Created by Nabil Kazi on 14/07/20.
//  Copyright © 2020 Nabil Kazi. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
