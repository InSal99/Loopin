//
//  ProjectViewModel.swift
//  Loopin
//
//  Created by Celine Margaretha on 10/01/24.
//

import Foundation
import Combine
import SwiftUI

class ProjectViewModel: ObservableObject, Identifiable {
    private weak var projectRepository = ProjectRepository.shared
    private weak var authService = AuthenticationService.shared

    @Published var project: Project
    
    private var cancellables: Set<AnyCancellable> = []
    
    var id = ""
//    var isAllowedToEdit = false
//    var isLiked = false
    
//    var commentListViewModel : CommentListViewModel?
//    var presentationMode: Binding<PresentationMode>?

    init(project:Project) {
        self.project = project
        $project
            .compactMap{$0.id}
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
    
    }
    
   
    func update(project:Project) {
        projectRepository?.update(project)
    }
    
    func remove() {
        projectRepository?.remove(project)
    }
    
}
