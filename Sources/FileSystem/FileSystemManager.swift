import Foundation

public protocol IFileSystemManager {

    func createOrReplace(
            data: Data,
            fileNameWithExtension: String,
            destination: FileManager.SearchPathDirectory
    ) -> Result<URL, FileError>

    func createOrReplace(
            data: Data,
            fileName: String,
            fileExtension: String,
            destination: FileManager.SearchPathDirectory
    ) -> Result<URL, FileError>

    func getDataFromFile(url: URL) -> Result<Data, FileError>

    func exists(
            fileName: String,
            fileExtension: String,
            destination: FileManager.SearchPathDirectory
    ) -> URL?

    func exists(url: URL) -> URL?

    func copy(fromUrl: URL, toUrl: URL) throws

    func delete(url: URL) throws

    func getFileLocationUrl(
            fileNameWithExtension: String,
            destination: FileManager.SearchPathDirectory
    ) -> URL

    func getFileLocationUrl(
            fileName: String,
            fileExtension: String,
            destination: FileManager.SearchPathDirectory
    ) -> URL

    func getFromResources(fileName: String, fileExtension: String) throws -> Data

    func cleanCache()

    func getFileDate(path: String) -> Date?

    func isAlternateAppIconExists(eventId: Int) -> Bool
}

public class FileSystemManager: IFileSystemManager {
    private let fileManager: FileManager

    public init(
            fileManager: FileManager = .default
    ) {
        self.fileManager = fileManager
    }

    public func getDataFromFile(url: URL) -> Result<Data, FileError> {
        do {
            return .success(try Data(contentsOf: url))
        } catch {
            return .failure(.unableToReadFile(cause: error))
        }
    }

    public func createOrReplace(
            data: Data,
            fileNameWithExtension: String,
            destination: FileManager.SearchPathDirectory
    ) -> Result<URL, FileError> {
        let fileLocationUrl = self.getFileLocationUrl(
                fileNameWithExtension: fileNameWithExtension,
                destination: destination
        )

        return createOrReplace(fileLocationUrl: fileLocationUrl, data: data)
    }


    public func createOrReplace(
            data: Data,
            fileName: String,
            fileExtension: String,
            destination: FileManager.SearchPathDirectory
    ) -> Result<URL, FileError> {
        let fileLocationUrl = self.getFileLocationUrl(
                fileName: fileName,
                fileExtension: fileExtension,
                destination: destination
        )

        return createOrReplace(fileLocationUrl: fileLocationUrl, data: data)
    }

    private func createOrReplace(fileLocationUrl: URL, data: Data) -> Result<URL, FileError> {
        do {
            if fileManager.fileExists(atPath: fileLocationUrl.path) {
                try self.fileManager.removeItem(at: fileLocationUrl)
            }

            fileManager.createFile(atPath: fileLocationUrl.path, contents: data)
            return .success(fileLocationUrl)
        } catch {
            return .failure(.unableToCreateFile(cause: error))
        }
    }

    public func exists(
            fileName: String,
            fileExtension: String,
            destination: FileManager.SearchPathDirectory
    ) -> URL? {
        let fileLocationUrl = self.getFileLocationUrl(fileName: fileName, fileExtension: fileExtension, destination: destination)

        if fileManager.fileExists(atPath: fileLocationUrl.path) {
            return fileLocationUrl
        } else {
            return nil
        }
    }

    public func exists(url: URL) -> URL? {
        if fileManager.fileExists(atPath: url.path) {
            return url
        } else {
            return nil
        }
    }

    public func copy(fromUrl: URL, toUrl: URL) throws {
        do {
            try fileManager.copyItem(atPath: fromUrl.path, toPath: toUrl.path)
        } catch {
            throw FileError.unableToCreateFile(cause: error)
        }
    }

    public func delete(url: URL) throws {
        do {
            try fileManager.removeItem(at: url)
            print("DEV file deleted at url \(url)")
        } catch {
            throw FileError.unableToDeleteFile(cause: error)
        }
    }

    public func getFileLocationUrl(fileName: String,
                            fileExtension: String,
                            destination: FileManager.SearchPathDirectory) -> URL {

        getFileLocationUrl(fileNameWithExtension: "\(fileName).\(fileExtension)", destination: destination)
    }

    public func getFileLocationUrl(fileNameWithExtension: String,
                            destination: FileManager.SearchPathDirectory) -> URL {

        let directoryUrl = try! FileManager.default.url(
                for: destination,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
        )

        return directoryUrl.appendingPathComponent("\(fileNameWithExtension)")
    }

    public func getFromResources(fileName: String, fileExtension: String) throws -> Data {
        let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension)
        guard let filePath = url else {
            throw FileError.bundleResourceIncorrectUrl(name: fileName, ext: fileExtension)        }

        do {
            return try Data(contentsOf: filePath)
        } catch {
            throw FileError.unableToCreateFile(cause: error)
        }
    }

    public func cleanCache(){
        let cacheURL =  FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let fileManager = FileManager.default
        do {
            let directoryContents = try? FileManager.default.contentsOfDirectory( at: cacheURL, includingPropertiesForKeys: nil, options: [])
            guard let contents = directoryContents else {
                return
            }
            for file in contents {
                do {
                    try? fileManager.removeItem(at: file)
                }
            }
        }
    }

    public func getFileDate(path: String) -> Date? {
        let creationDateAttr = (try? fileManager.attributesOfItem(atPath: path))?[.creationDate]
        guard
                let attr = creationDateAttr,
                let nsDate = attr as? NSDate
        else {
            return nil
        }

        return Date(timeIntervalSinceReferenceDate: nsDate.timeIntervalSinceReferenceDate)
    }


    public func isAlternateAppIconExists(eventId: Int) -> Bool {
        guard let icons = Bundle.main.object(forInfoDictionaryKey: "CFBundleIcons") as? [String: Any],
              let alternateIcons = icons["CFBundleAlternateIcons"] as? [String: Any] else {

            return false
        }

        let icon = alternateIcons.first { $0.key == "event-icon_\(eventId)" }

        if icon != nil {
            return true
        } else {
            return false
        }
    }
}
