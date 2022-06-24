# Infrastructure Configuration

## Introduction

In this lab we will build the infrastructure that we will use to run the rest of the workshop.  The sample application is a showcase of several Oracle Cloud Infrastructure services in a unified reference application. It implements an e-commerce platform built as a set of micro-services. The accompanying content can be used to get started with cloud native application development on Oracle Cloud Infrastructure.

The repository contains the application code as well as the Terraform code, that creates all the required resources and configures the application on the created resources.

Estimated Time: X minutes

### Objectives

In this lab, you will:
-	Deploy the Oracle Cloud Infrastructure Container Engine for Kubernetes(OKE).


### Prerequisites

- Log-in to your OCI tenancy.
  

## Task 1: Enable Logging Analytics Service
  - First you need to enable Logging analytics service, go to the menu and select **Observability and Management** and select **Logging Analytics**

  ![](./images/img1.png)

  - Then click  **Start Using Logging Analytics**

  ![](./images/img2%20copy.PNG)

  - Once done, click **Take Me To Log Explorer**

  ![](./images/img3%20copy.PNG)

## Task 2: Create a Dynamic Group and Set the Required Policies

  - To set some policies we will have to first create a Dynamic Group, we will need a compartment id, which you can find at **Identity & Security > Compartment** copy Compartment ocid and  save it on a separate text file for later,
  ![](images/compartment.png)

 - Now go back to the menu on the left top side and choose **_Identity & Security_**, then **Domains > Dynamic Groups**

  ![](images/menu-1.png)
  ![](images/domains.png)

  ![](images/domainsinterface.png)
   ![](images/dynamicgroup.png)
 - Create a Dynamic Group called **_dynamic-group-oke-node-pool_** that matches OKE node pool workers with matching rule:

    ![](images/createdynamicgroup.png)

    ![](images/dynamicrule.png)
    ```
    <copy>All {instance.compartment = '<COMPARTMENT_NAME>'}</copy>
    ```  
   You have to replace **`COMPARTMENT_NAME`** for the compartment name where your Kubernetes Cluster is going to be created.
 
 - Back to the **Identity** from the left side menu select **_Policies_**, and create a policy to allow access to Log Group with the following rule:
  
  ![](images/policymenu.png)
  
    ```
    <copy>
    Allow dynamic-group dynamic-group-oke-node-pool to {LOG_ANALYTICS_LOG_GROUP_UPLOAD_LOGS} in compartment <COMPARTMENT_NAME>  
    </copy>
    ```
    ```
    <copy>
    Allow dynamic-group <DynamicGroupName> to use log-content in tenancy
    </copy>
    ```
  ![](images/policycreate.png)
## Task 2: Create a Log Source in the Logging Analytics
 
   A **_log source_** is the built-in definition of where log files are located and how to collect, mask, parse, extract and enrich the collected log data.

 - From the top left menu choose **_Observability & Management > Logging Analytics > Administration_**

  ![](images/menu.png)

 - On the side menu, click **_Sources_**.

 - Click **_Create Source_** and fill the form with the following information:
   
    ```
      Name: <copy>hello-api-source</copy>
    ```
    ```
      Description: <copy>Hello API App Source</copy>
    ```
    ```
      Source Type: <copy>File</copy>
    ```
    ```
      Entity Types: <copy>OCI Compute Instance</copy>
    ```
    ```
      Parser: <copy>Automatically parse time only</copy>
    ```
 
 - Click **_Create Source_** to confirm.

## Task 3: Deploy the Oracle Cloud Infrastructure Container Engine for Kubernetes(OKE)

  - Go to OCI Web Console and open **_Cloud Shell_**.
    ![](./images/cloud-shell.png)

  - Clone this repository with:
    ```
    <copy>
    git clone https://github.com/vmleon/oci-hello-loganalytics.git
    </copy>
    ```
   ![](images/gitclone.png)
  - Change directory to oci-hello-loganalytics/provisioning:
    ```
    <copy>
    cd oci-hello-loganalytics/provisioning
    </copy>
    ```
   


  - Terraform initiate:

    ```
    <copy>
    terraform init
    </copy>
    ```
   ![](images/tfinit.png)
  - Before we apply the infrastructure with terraform, we need to set some variables.

  - Let's start with copy the template variable file:

    ```
    <copy>
    cp terraform.tfvars_template terraform.tfvars
    </copy>
    ```
    ![](images/cptf.png)
  - Get the values and copy them aside from running these commands

    Region:
    ```
    <copy>
    echo $OCI_REGION
    </copy>
    ```
    Tenancy:
    ```
    <copy>
    echo $OCI_TENANCY
    </copy>
    ```
    ![](images/savetenancy.png)
  If using the root compartment (trials) for compartment_ocid set the OCI_TENANCY value as well, otherwise, use the specific OCID compartment:

  - We need again the Compartment ocid that we saved earlier in task1, if you haven't save it you can find in from cloud shell as follows, replace <COMPARTMENT_NAME> by the name of the compartment.

    ```
    <copy>
    oci iam compartment list \
      --all \
      --compartment-id-in-subtree true \
      --query 'data[0].id' \
      --name <COMPARTMENT_NAME>
    </copy>
    ```
 - Edit the file with vim:

    NOTE: You can leave empty the profile property

    ```
    <copy>
      vim terraform.tfvars
    </copy> 
    ```
    ![](images/tfplain.png)
 - An example of the final result would be:
  
    ```
    <copy>
      region = "eu-frankfurt-1"
      tenancy_ocid = "ocid1.tenancy.oc1..aaa............."
      compartment_ocid = "ocid1.compartment.oc1..aaa.............""
      profile = ""
    </copy>
    ```
    ![](images/tfinfo.png)
 - Run the Terraform apply:
    ```
    <copy>
      terraform apply -auto-approve
    </copy>
    ```
- After 10 to 20 minutes the resources should be created.

 You will see something like this:

    ```
    <copy>
      Apply complete! Resources: 19 added, 0 changed, 0 destroyed.

      Outputs:

      deployed_oke_kubernetes_version = "v1.22.5"
      generated_private_key_pem = <sensitive>
      kubeconfig_for_kubectl = "export KUBECONFIG=$(pwd)/generated/kubeconfig"
    </copy>
    ```

- Run that last command:

    ```
    <copy>
    export KUBECONFIG=$(pwd)/generated/kubeconfig
    </copy>
    ```

    ![](images/kubeconf.png)

  Well done, you can now proceed to the next lab!

## **Acknowledgements**
  - **Author** - Rawan Aboukoura - Technology Product Strategy Manager, Victor Martin - Technology Product Strategy Manager 
  - **Contributors** -
  - **Last Updated By/Date** -
