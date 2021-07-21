//
//  SafariBrowserView.swift
//  TMDB-MovieList
//
//  Created by Surya Pratap Singh on 20/07/21.
//

import SafariServices
import SwiftUI

struct SafariBrowserView: UIViewControllerRepresentable {
    
    let url: URL

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let safariVC = SFSafariViewController(url: self.url)
        return safariVC
    }
}
