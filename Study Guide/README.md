#  Wrapper Classes

Hello! This starter project is meant to help you practice using common features of Plist, UserDefaults, FileManager and Keychains.
These classes you will build in this project do not have to be generic or 100% reusable.
You can design one or more classes to be deeply tied to an app's usecase like so:

```
class UserDefaultsStore {
    
    private let userDefaults = UserDefaults.standard
    
    var isFirstTimeLaunch: Bool {
        get {
            userDefaults.bool(forKey: "IS_FIRST_TIME_LAUNCH")
        }
        set {
            userDefaults.set(newValue, forKey: "IS_FIRST_TIME_LAUNCH")
        }
    }
    
    // More properties the app uses here
    // ...
}
```

Although, some of classes can be made very generic like so:

```
class File {
    init(location: URL) {
        
    }
    
    /// Store the given string in the file
    func save(contents: String) {
        ...
    }
}
```

## Plist

For this class, methods have been provided for the CRUD features:

- Reading the contents from the main bundle (files stored in the Xcode project)
- Reading the contents from the app's Sandbox (e.g. Documents, Library, or temp folder)
- Storing new content (this would only work if the Plist is saving in the app's Sandbox)
- Deleting the contents (this would only work if the Plist is saving in the app's Sandbox) 

Feel free to change or add new methods. As long as the wrapper covers the CRUD features

## UserDefaults

Think about the pain points of using UserDefaults out-of-the-box:

- Keys can have typos
- Types stored at a key can mismatch the type when reading

Since there are little coding steps in performing the CRUD operations, this wrapper not being fully generic is acceptable

## FileManager

For this class, methods have also been provided for the CRUD features:

- Reading the contents from the app's Sandbox (e.g. Documents, Library, or temp folder)
- Storing new content (e.g. strings, encodable types, or Data types)
- Deleting the contents 

Feel free to change or add new methods. As long as the wrapper covers the CRUD features

## Keychains

For this class, think about the major pain points of using the Keychain API:

- Lots of lines of code just to store some data at a given key
- Keys can have typos
- Types stored at a key can mismatch the type when reading

## Testing Each Class
