# IIS Deploy action

This action allows to deploy a website on IIS.

This action is based on Microsoft scripts bundled with some versions of Visual Studio.

The MS Deploy configuration uses these default settings:
- `WebPublishMethod` = `MSDeploy`
- `SkipExtraFilesOnServer` = `false`
- `EnableMSDeployAppOffline` = `true`

Also, some generic directories and files are excluded to prevent data loose:

```
'ExcludeFiles'=@(
    @{'objectname'='filePath';'absolutepath'='.*google.*\.html'},
    @{'objectname'='filePath';'absolutepath'='.*BingSiteAuth\.xml'},
    @{'objectname'='filePath';'absolutepath'='logs\\.*'},
    @{'objectname'='dirPath';'absolutepath'='logs'},
    @{'objectname'='filePath';'absolutepath'='data\\.*'},
    @{'objectname'='dirPath';'absolutepath'='data'}
)}
```

## Requirements

- A Windows runner
- A runner with Web Deploy 3.0+ (more information [here](https://www.iis.net/downloads/microsoft/web-deploy) and [here](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd568996(v=ws.10)))

## What's new

Refer [here](CHANGELOG.md) to the changelog.

## Inputs

It is recommended to put the `msdeploy-username` and `msdeploy-password` into a GitHub secrets to prevent clear value in your workflow.

| Input | Required | Example | Default Value | Description |
|-|-|-|-|-|
| `website-name`          | Yes | `www.yourwebsite.ca`  | | Name of your website on IIS |
| `msdeploy-service-url`  | Yes | `https://yourwebsite.ca:8172` | | MS Deploy Service URL |
| `msdeploy-username`     | Yes | `username`        | | Username used by Basic authentication to the MS Deploy Service |
| `msdeploy-password`     | Yes | `password`        | | Password used by Basic authentication to the MS Deploy Service |
| `source-path`           | Yes | `${{ github.workspace }}\website\publish`  | | The path to the source directory that will be deployed |
| `skip-extra-files`      | No  | `true`  | `false` | Keep existing directories/files during deployment |

## Usage

<!-- start usage -->
```yaml
- uses: ChristopheLav/iis-deploy@v1
  with:
    website-name: 'MyWebsite'
    msdeploy-service-url: ${{ secrets.MSDEPLOY_URL }}
    msdeploy-username: ${{ secrets.MSDEPLOY_USERNAME }}
    msdeploy-password: ${{ secrets.MSDEPLOY_PASSWORD }}
    source-path: ${{ github.workspace }}\website\publish
    skip-extra-files: false
```
<!-- end usage -->

## License

The scripts and documentation in this project are released under the [MIT License](LICENSE)