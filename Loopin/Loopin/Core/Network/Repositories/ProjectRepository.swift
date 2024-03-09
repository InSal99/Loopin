//
//  ProjectRepository.swift
//  Loopin
//
//  Created by Celine Margaretha on 10/01/24.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class ProjectRepository: ObservableObject {
    
    static let shared = ProjectRepository()
    
    //MARK: Firebase API
    private let parentPath: String = "users"
    private let path: String = "projects"
    private let database = Firestore.firestore()
    
    private weak var authenticationService = AuthenticationService.shared
    private var cancellables: Set<AnyCancellable> = []
    private var listener: ListenerRegistration?
    
    @Published var projects: [Project] = []

    init(){
        addListeners()
    }
    
    private func addListeners() {
        /// Remove existing listener if any
        listener?.remove()
        
        authenticationService?.$user
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.get()
            }
            .store(in: &cancellables)
    }
    
    func get() {
        guard authenticationService?.user?.id != nil else {return}
        listener = database.collection(parentPath).document((authenticationService?.user?.id)!).collection(path)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error getting cards: \(error.localizedDescription)")
                    return
                }
                
                self.projects = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: Project.self)
                } ?? []
            }
        print("Project Repo - get projects: \(self.projects)")
    }
    
    func add(_ project: Project, completion: @escaping (Bool) -> Void) {
        print("Project Repo - add with userId: \(String(describing: authenticationService?.user?.id))")

        guard authenticationService?.user?.id != nil else {
            print("Project Repo - add with userId: \(String(describing: authenticationService?.user?.id))")

            completion(false)
            return
        }

        do {
            _ = try database.collection(parentPath).document((authenticationService?.user?.id)!).collection(path).addDocument(from: project)
            completion(true)
        } catch {
            completion(false)
            fatalError("Unable to add card: \(error.localizedDescription).")
        }
    }
    
    func update(_ project: Project) {
        do {
            try database.collection(parentPath).document((authenticationService?.user?.id)!).collection(path).document(project.id!).setData(from: project)
        } catch {
            fatalError("Unable to update card: \(error.localizedDescription).")
        }
    }
    
    func remove(_ project: Project) {
        database.collection(parentPath).document((authenticationService?.user?.id)!).collection(path).document(project.id!).delete { error in
            if let error = error {
                print("Unable to remove card: \(error.localizedDescription)")
            }
        }
    }
    
}
