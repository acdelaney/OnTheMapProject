//
//  GCDBlackBox.swift
//  OnTheMap_Project
//
//  Created by Andrew Delaney on 8/26/17.
//  Copyright © 2017 Andrew Delaney. All rights reserved.
//

import Foundation

// To perform updates on the main thread

func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
