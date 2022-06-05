# IIS Deploy action

This action allows to deploy a website on IIS.

## What's new

Refer [here](CHANGELOG.md) to the changelog.

### Inputs

It is recommended to put the `msdeploy-username` and `msdeploy-password` into a GitHub secrets to prevent clear value in your workflow.

| Input | Required | Example | Default Value | Description |
|-|-|-|-|-|
| `website-name`          | Yes | `www.pinnula.fr`  | | Name of your website on IIS |
| `msdeploy-service-url`  | Yes | `https://www.pinnula.fr:8172` | | MS Deploy Service URL |
| `msdeploy-username`     | Yes | `username`        | | Username used by Basic authentication to the MS Deploy Service |
| `msdeploy-password`     | Yes | `password`        | | Password used by Basic authentication to the MS Deploy Service |
| `source-path`           | Yes | `${{ github.workspace }}\website\publish`  | | The path to the source directory that will be deployed |

## Usage

<!-- start usage -->
```yaml
- uses: pinnula-ca/iis-deploy@v1
  with:
    website-name: 'MyWebsite'
    msdeploy-service-url: ${{ secrets.MSDEPLOY_URL }}
    msdeploy-username: ${{ secrets.MSDEPLOY_USERNAME }}
    msdeploy-password: ${{ secrets.MSDEPLOY_PASSWORD }}
    source-path: ${{ github.workspace }}\website\publish
```
<!-- end usage -->

## License

This is a private repository.