//
//  ProjectListViewModel.swift
//  Loopin
//
//  Created by Celine Margaretha on 10/01/24.
//

import Combine

class ProjectListViewModel: ObservableObject {

    static let shared = ProjectListViewModel()
    
    @Published var projectRepository = ProjectRepository.shared
    @Published var projectViewModels : [ProjectViewModel] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        projectRepository.$projects.map { posts in
            posts.map(ProjectViewModel.init)
        }
        .assign(to: \.projectViewModels, on: self)
        .store(in: &cancellables)
    }
    
    
    func add(_ project: Project, completion: @escaping (Bool) -> Void ) {
        projectRepository.add(project) { isSuccess in
            completion(isSuccess)
        }
    }
    func remove(_ project: Project) {
        projectRepository.remove(project)
    }
    func reset(){
        projectViewModels.removeAll()
    }
}
