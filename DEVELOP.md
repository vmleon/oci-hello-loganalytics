# Develop the stack

You can run the stack locally on your computer or OCI Cloud Shell. Otherwise go to the [README](./README.md) to deploy the stack using OCI Resource Manager.

## Requirements

You must have [OCI CLI](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm) installed and configured.

It will request the number of the region. After this command a browser window will pop up, sign in using the browser.

```
oci session authenticate
```

The PROFILE will be stored in the `~/.oci/config` file.

Validate the token (optional):

```
oci session validate --profile PROFILE_NAME
```

Refresh the token if it expires (about every 30min)

```
oci session refresh --profile PROFILE_NAME
```
