
import Moya
public enum ProviderFactory {

    /// Generic provider maker
    public static func make<T: TargetType>(for type: T.Type = T.self, plugins: [PluginType] = []) -> MoyaProvider<T> {
        MoyaProvider<T>(plugins: plugins)
    }
}
