//
//  HelperManager.swift
//  Voyager
//
//  Created by Glenn Reinard Stanis on 25/05/23.
//

import Foundation
import CoreLocation
import UserNotifications
import UIKit

func provideHapticFeedback() {
        let feedbackGenerator = UINotificationFeedbackGenerator()
        feedbackGenerator.prepare()
        feedbackGenerator.notificationOccurred(.warning)
    }
