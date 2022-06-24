# Monitoring

## Introduction

In this lab we will unleash the capabilites of  and review aggregated data in a dashboard and explore the available logs in the Log Explorer. 

Estimated Time: X minutes

### Objectives

In this lab, you will:
- simulate workload


## Task 1: Create Load

- Open the Cloud Shell
![](images/cs.png)
- Access the OKE cluster 
![](images/accesscluster.png)

- Create the load
    ```
    <copy>
    kubectl create -f https://raw.githubusercontent.com/oracle-quickstart/oci-cloudnative/master/src/load/load-dep.yaml

    </copy>
    ```
    ![](images/createload.png)

## Task 2: LA Dashboard

- After Some minutes you find changes in the views

    ![](images/editdashboard.png)

## Task 3: Check firing Alarms

- From the Menu select **O&M > Monitoring > Alarm Status**
![](images/alarm.png)
- You will see the a firing alarm which you can find more information by clicking on it
![](images/alarm2.png)
- Check the email inbox you used creating the alarm to see the notification
![](images/emailnotif.png)
- Finally, remove the load created from the Cloud Shell
![](images/deleteload.png)

## **Acknowledgements**
  - **Author** - Rawan Aboukoura - Technology Product Strategy Manager, Victor Martin - Technology Product Strategy Manager 
  - **Contributors** -
  - **Last Updated By/Date** -
