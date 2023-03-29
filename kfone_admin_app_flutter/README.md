# Kfone Admin Frontend

## Installation

### Requirements
1. Flutter version 3.7 or higher (You can install Flutter using the following [documentation](https://docs.flutter.dev/get-started/install))

### Setup
1. Clone the repository
2. Navigate to the kfone_admin_app_flutter directory
3. Run `flutter run` to run the app.

### Using the `config/config.json` file
```yaml
{
    "AuthorizationConfig": {
        "BaseOrganizationUrl": <PARENT ORGANIZATION URL>,
        "ClientId": <CLIENT ID>,
        "Scopes": [
            "openid",
            "email",
            "profile"
        ],
        "APIBaseUrl": <BASE URL OF THE BACKEND>
    },
    "LoginCallbackUrl": "com.wso2.kfone.admin.app://login-callback",
    "LocalStoreKey": {
        "AccessToken": "com.wso2.kfone.admin.app_access_token",
        "IdToken": "com.wso2.kfone.admin.app_id_token",
        "AccessTokenExpirationDateTime": "com.wso2.kfone.admin.app_access_token_expiration_date_time"
    }
}
```
