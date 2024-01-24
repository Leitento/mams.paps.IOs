

import Foundation
import CoreData

final class CoreDataService {
    
    //MARK: - Singleton
    static let shared = CoreDataService()
    
    private init() {}
    
    //MARK: - Private properties
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UserModel")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("‼️ Can not load persistant stores \(error)")
            }
        }
        return container
    }()
    
    //MARK: - Private Methods
    private func setContext() -> NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    //MARK: - Methods
    func saveUser(user: User?) {
        guard let user else { return }
        
        let context = setContext()
        
        if getUser(username: user.login) != nil {
            print("Такой пользователь уже существет")
            return
        }
        
        let currentUser = UserModel(context: context)
        currentUser.username = user.login
        currentUser.name = user.userName
        currentUser.city = user.city
        
        do {
            try context.save()
        } catch {
            print("Error saving user: \(error.localizedDescription)")
        }
    }
    
    func getUser(username: String) -> UserModel? {
        let request: NSFetchRequest<UserModel> = UserModel.fetchRequest()
        let predicate = NSPredicate(format: "username == %@", username)
        request.predicate = predicate
        
        do {
            let results = try setContext().fetch(request)
            return results.first
        } catch {
            print("Error fetching weather data: \(error.localizedDescription)")
            return nil
        }
    }
}
