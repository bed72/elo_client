enum Methods : String {
    case GET = "get"
    case PUT = "put"
    case POST = "post"
    case PATH = "path"
    case DELETE = "delete"
}

struct Params {
    var path: String
    var body: [String: Any]? = nil
    var headers: [String: Any]? = nil
    var method: String = Methods.GET
    var queryParams: [String: Any]? = nil

    init(
        path: String, 
        body: [String: Any]?, 
        headers: [String: Any]?,
        method: [String: Any]?,
        queryParams: [String: Any]?,
    ) {
        self.path = path
        self.body = body
        self.headers = headers
        self.method = method
        self.queryParams = queryParams
    }
}